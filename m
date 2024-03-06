Return-Path: <linux-kselftest+bounces-5964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036FD872BC6
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 01:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF4E1F2177D
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Mar 2024 00:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0E98BF1;
	Wed,  6 Mar 2024 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZR6TeWyz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C7263CF
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Mar 2024 00:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684986; cv=none; b=O8Jix4UUn2rKv+EekvyOSnRvfOIpNN5IUrteqw7wcfTVsdvt4nFXGsXNJjtxRuMzZAcpIB3WFOnxOmN9Ndm9bgpKFVfi9XAabmy1reEFnx3S4HPhMYY4RtY4BrNYDC6QLsUF9liOjI3CytBQd/w9ftjDObHdrSdvuqRKOjzM2b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684986; c=relaxed/simple;
	bh=3TGXNtbSnGqUmrRKGS4Vxyjh7otthNXIvoCLbmKVZJo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YlNfoKe9/Z3gflQaa2Cvu9Uhfv3qPQEEpL0DlXkCCQTcQ9XUvaq6xczaum8Zrx4eOi7CJU0nUPW94Vw+23knwlAPpkTftYPvCHHx81tAyzugiOZKn+dIlTCDIcH8tmnSCVfDv9U4wPBRgYgDLlcBiK0/HDZ9oiIHMbBTVUx5qtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZR6TeWyz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so9423485276.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Mar 2024 16:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709684984; x=1710289784; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSB6RmxldMWGsQwbWc2w1sJWlx2GAlKRYfswIj2uSas=;
        b=ZR6TeWyzKG5mLn3oMZfBsFNK5HN82QByxp6RoHYJqxfk6KgS3YdwGsr4GSnd3fU7Ii
         e8Lf9y+l+OcelcjWqAPE5+YCzk19fj0sCK/YGYz5ttIIo9x3FTtQ4o2OYxXXEQzu9rBx
         kgB+RIKw5KgYuKGKKwMO5/pP/zgDgPxHfwCm6tZfQlbVuAqSL5DdnWIEmATCIE6hoitC
         irEmkUO5pdi0Q8c5vxEal8nV6BXu6XyV1K4mLp7V1ociUnUGHn34TvsSxip/2B3ZxIec
         3UX8Etjayt0ljbPswzBiw/cVdeLY5IphgRFFsFu+7VR5ty884zmDY0Yy6GcrdFvRPL3g
         QqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709684984; x=1710289784;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xSB6RmxldMWGsQwbWc2w1sJWlx2GAlKRYfswIj2uSas=;
        b=vwBvMazXkYo/OQ+9jkEE5DiTaztRp8rAJKWXJfkERnbtHgPuYSh6L1Hjvq/2VO1Ps7
         TxIjmkulI5F6OYreyxmy9ScPdTx/HnTUWDnVFGyCDBqzbsdGECwuRlP1DTzmv0sHQmvs
         2Zt9AxZ8KJLdAgS8/ttuHwbf0XUkYI8IJZ5u363m6Fsk6zfGpRN/mwbvrhqJk9thQkFp
         lAo9Ze2uZXKFkQ+DtzzhqWLO5oOLsz6Sbj6l9GWPRbKmWTVdTfxnul4NrOApHchNYLsW
         zoIPxU3VZhjFoS2d6y7qMTFNxIoG7XI7l8BXkenf3pADEN0AVCXxyzAx9la3KdMdq6Ou
         vU6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVhi3pwidvy/bPBLjdY/jIV7sRzDC/WVgbTMUYw7U4ODfwzPUYJZDocFKAsghUqcpe9MqmgJsQi/xs5pqLqT+aSDB2u77XjDserHWOQSIq
X-Gm-Message-State: AOJu0Yww5uQZZ9i6AU4ko2Ar5g4O+HGf2zVWvmmyUwiZTvOwdgC2UEVF
	4D83/+AbRA+ZGo3Q/qLg+fF+TAuax/V5UzCkT/9gm1DNGRcm+NTHcyHxGOwBicjXd76KVAOmDtP
	gQA==
X-Google-Smtp-Source: AGHT+IHq9WdopNkqHirkj1ZNnJCotQ7fHu7uj+p8bztDqe+dPoiGmxwesLZ6INERbKQTG2EJNzDhuuJ1Pgk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:dc4c:0:b0:dc6:d1d7:d03e with SMTP id
 y73-20020a25dc4c000000b00dc6d1d7d03emr589896ybe.8.1709684983800; Tue, 05 Mar
 2024 16:29:43 -0800 (PST)
Date: Tue,  5 Mar 2024 16:29:35 -0800
In-Reply-To: <20240227015716.27284-1-dongli.zhang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227015716.27284-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <170967423579.413845.13663361620906682493.b4-ty@google.com>
Subject: Re: [PATCH 1/1] KVM: selftests: close the memfd in some gmem tests
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Dongli Zhang <dongli.zhang@oracle.com>
Cc: linux-kernel@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 26 Feb 2024 17:57:16 -0800, Dongli Zhang wrote:
> Add the missing close(fd) in guest_memfd_test.c and
> private_mem_conversions_test.c.

Applied to kvm-x86 selftests, with a massaged changelog.  Thanks!

[1/1] KVM: selftests: Explicitly close guest_memfd files in some gmem tests
      https://github.com/kvm-x86/linux/commit/e9da6f08edb0

--
https://github.com/kvm-x86/linux/tree/next

