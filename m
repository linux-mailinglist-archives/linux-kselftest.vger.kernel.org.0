Return-Path: <linux-kselftest+bounces-46898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69819C9C576
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 18:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C7E64E1A17
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 17:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7DB2BE7BB;
	Tue,  2 Dec 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hC8CzX/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B698728136F
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695401; cv=none; b=teB5yoojcSIfXzeEqmypHMPrsZzn9KLKpWcWoxVe7D4wCG+WMWeuMUuk0gUJAsf/adj0/AOM+DYEZR20Rk76s7Y+F+PZZzxLvUCBLWRZSOQj8VSkJrAxU6nxfFB0cMqglFQn4KXDI6RWlP1ONH26LSrBR0V/Pa6LRHJp/fEGkKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695401; c=relaxed/simple;
	bh=umTx2taCeC5963qb+wkytzIDyDWomHN2zHt2ismTJ6s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rhmx0R3DzpW1EyfkQGJUF6KPWzBWcrdLyZ0oKMEqt2SSUbBRpUMKmVQxDWrrOCEIK/6b2TY886Bnj2dZVY+XvK4EOqmI3q/Pu1ZMvNwtzSpCSabGfhYBDQNjg7TQ0ndeaW8efPdN2OFS2Nn0BKYcL4SOVcVPVvr4CEANVCsBhlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hC8CzX/b; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343daf0f488so5000756a91.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 09:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764695399; x=1765300199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E5WJmQwtaiSGjdX3hvQ5G0fLkQaPiiuvbOSh5KLZb28=;
        b=hC8CzX/bEQQn6zAnkHb+aL6oVPH/Le/G8XraOfFb4vCkpEFIxyF/CHZ/9BBCGHYH5A
         EkgErk6VfOzGBrrWzW1hezMqaxngo2IcxidwvRpFucWbOGJxg38v4OaX0vZczlPkznA/
         h+kLBopawJGKpvfT5fqQxAHT1y+ccS7fDoSeSVNAhooaa3D1ouaXgqf9nHTiHQ7hJ/jI
         /fPgqCiPCYapYMfvYzzzf5BitPc+fMpKf1CFRIBjNQ1Af/bHPHS+kTPGUokcyGpnsWYZ
         mYSz2Ccy0QmgFjpwR98+OPNPnxCdxpEyX/VXr7MTLOdSEvJXvyyH8R/oTLCPB9S1gib+
         1xPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695399; x=1765300199;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E5WJmQwtaiSGjdX3hvQ5G0fLkQaPiiuvbOSh5KLZb28=;
        b=Khfh0G6FN0Olv60z4Aw4BW7CElcyicMH4gk3lKhNyLwCoAQF5IlGuKPkqH1dJy6V+P
         8YKxgvN9jDA2JJ3KOLCVAP6OdTxvllxFLEXby/mI2oQzUXi66g26ClJ3jAfHWlKQhg2a
         woU5JYL1C3p0EQOma5xxe0u+LRaURFcKfBzMANxsTJIiQC80mtiutO9qpHzm4jcDzfkn
         OvyqT0g9T5tCqDkc/NSuPUfruetJiFx+PO2dSPBXocrWaNs/823hPOa3NE254vgeuPdF
         BLMPIKxWV6hQobO7Dc47nmr5kntprC2tXFqhL2V4vEvczo2my+igFEbmeKd1uC3keEpY
         D5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCURvqUFhdBOzSUhHsRWJhZ0fh7vMbsiTh19gPlGpzukHXz2USVIVamA+Mq/Wh06NJSZ60jXykEqVrE2Rv0MtWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4eRTUVw8w6/r8l7eSx/Tj4hqTA4mfGW3NZLoEW7MWinkddM6s
	48PjkP4RvNhW+SRskRGclaY2k4uaOlG6VEYtqyJjMHPVrR8ew14Bp2e7eN/qGnPAytGJdPl+LfX
	m+AsGpw==
X-Google-Smtp-Source: AGHT+IF/Endm213qEFcUNzAd2NTgktVOwQl4jMK+4bmG2i5epcnkPYvc/1IUDYusSfDWawT+jd3lEpUj2Bs=
X-Received: from pjbta16.prod.google.com ([2002:a17:90b:4ed0:b0:345:b608:e5b0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b41:b0:33f:f22c:8602
 with SMTP id 98e67ed59e1d1-3475ed6ac44mr30324034a91.26.1764695399033; Tue, 02
 Dec 2025 09:09:59 -0800 (PST)
Date: Tue,  2 Dec 2025 09:05:12 -0800
In-Reply-To: <20251124050427.1924591-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124050427.1924591-1-gshan@redhat.com>
X-Mailer: git-send-email 2.52.0.107.ga0afd4fd5b-goog
Message-ID: <176469500942.1209959.4892875353793397176.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Fix core dump in rseq_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvmarm@lists.linux.dev, 
	Gavin Shan <gshan@redhat.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org, 
	shan.gavin@gmail.com
Content-Type: text/plain; charset="utf-8"

On Mon, 24 Nov 2025 15:04:27 +1000, Gavin Shan wrote:
> In commit 0297cdc12a87 ("KVM: selftests: Add option to rseq test to
> override /dev/cpu_dma_latency"), a 'break' is missed before the option
> 'l' in the argument parsing loop, which leads to an unexpected core
> dump in atoi_paranoid(). It tries to get the latency from non-existent
> argument.
> 
>   host$ ./rseq_test -u
>   Random seed: 0x6b8b4567
>   Segmentation fault (core dumped)
> 
> [...]

Applied to kvm-x86 fixes, with a massaged shortlog.  FWIW, I'm planning on
sending Paolo a fixes pull request later this week, so this should make it
into 6.19-rc1.

[1/1] KVM: selftests: Add missing "break" in rseq_test's param parsing
      https://github.com/kvm-x86/linux/commit/1b9439c933b5

--
https://github.com/kvm-x86/linux/tree/next

