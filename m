Return-Path: <linux-kselftest+bounces-8774-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E19018B0C28
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9953B28714A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010315E206;
	Wed, 24 Apr 2024 14:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ChSeKFjG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA7E15958C;
	Wed, 24 Apr 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968025; cv=none; b=a7uot4sScZfxeYDSYMyxiK+GkKtTyXpA4loUWt4sXnWPNGdJ5xHWkmDZVNOCN6q4OzoRHLQ5OBRkEdidx7+61heu7EvFB+ym5WkCdSSlw6f+JE0QWJVVqB+tftYt/YPgWWIadYJ+DAXyRK7pqvPmhoTLyxk+JqbBOg7O/ksREDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968025; c=relaxed/simple;
	bh=8OxbnVuVsGdH1OzXR62wsUI5qBuxC0eXNE3oj1lyl0M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Fa+Q/F+ucHIcFij2GYF8gprjJXu7avnXKBOmQwWs5nLqQnL0b8finCCZBgWWkC49VThZMjEjrPyMy776G43KXuX8qPTCJZGYpvEwdutKUaPu7dZpoH14NomTqQU6EO4/Zoe3dFbS/7JCbPHqxPNlpMditoTrpZ5z+/uaachL5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ChSeKFjG; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78ef9ce897bso456161385a.0;
        Wed, 24 Apr 2024 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713968022; x=1714572822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmG6qca+RoKojW/MYD3CI3bp1D0UCREu+AgU0Gfk900=;
        b=ChSeKFjGhZJ1BsMsEhcqnMeUGK356O+YOHJJh9QYlh4Yq7FUaa3B7vLMeQVSEDuzNa
         ixvBcV2WYMiaNExOSsieH9/EMCcS1+9HujFM+ADadrVqcl9c3rMMIabj4PqaytTLhuKx
         YWTMF+PUoP4NM/97b0LLdPgXFQ6UO/uaAUxuj5JTXSq9szuryx7pgct8RBS1X7fHcxld
         /Bc4TYuKgy2jjcNmf2v1ey8f8XCDOOzuK3y3p8SdOSEl/Y0DIXBhdI03IWuyAOrI2PKT
         gaueHPZeNC378d12PoPK/CjwA+r0RUZ4eL7F+LqV8dD1oUdquSkIVhOQkxhbij64f3Z1
         RTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713968022; x=1714572822;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmG6qca+RoKojW/MYD3CI3bp1D0UCREu+AgU0Gfk900=;
        b=hGbyscHRBXXaiEpnT75cVbtUXnHQH9Y5E+THAqf9yxujNA3QR2xV9nx37E/QTDCSsP
         BwlzeqT28x/yM+3CrtQM1efnw+zDND5NdrRFDrkN4QEUis2GnlYNi+lYyukiPEr2SZZO
         5Dc0e7NW29DrwtoOe375BX+LBd+uBWUxPd/OiwH1f5+vq2M/TOFEGG47o0pJW0Rd37QS
         0gXM1vPD0K8OVUdCd07CYXlROYEDdsegt44QEaxP5hl0IGuzqmXs0Hcl7z7V9Fcav6TO
         IccjXj/S4OWAKSio3e7gy+8DCA9wbipLLQCeiXhmVzx/F7w/KNjUgBf89Y7MP+YFWv7K
         4kuA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKkW0CU2ZMCV1AAC+4+pzpxk8sEGWNoJLUXCNaPFS6O6705ZWLlpWyBWqpR1DJ+MF0L3wICbdwUn4lY5tyEgjaJy9y1BYZpainKQP7uAjm2LYSVh2M1J3y4laKu6+edSSAgxnk4iv
X-Gm-Message-State: AOJu0YxCeA4bVE4CQaX+UGwCMTgnmuh1EfFgugBy3CFiWN699gEvbdsR
	Kam/KlsfVb+bLje7hlNbOi0J7iEe1qtgCz4lee0FoD/Qp0SF+9h9
X-Google-Smtp-Source: AGHT+IGKYBsI3fyB1e1mqGmqlV5I5gjJ33MiG/zvSeR0EgHAz60G6Evlt7RYzjFWduK8yeB4sMx1ew==
X-Received: by 2002:a05:620a:4147:b0:790:8734:ed8c with SMTP id k7-20020a05620a414700b007908734ed8cmr3395560qko.16.1713968022498;
        Wed, 24 Apr 2024 07:13:42 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id j11-20020a05620a0a4b00b0078ec5e88805sm6090634qka.54.2024.04.24.07.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 07:13:42 -0700 (PDT)
Date: Wed, 24 Apr 2024 10:13:41 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 shuah@kernel.org, 
 petrm@nvidia.com, 
 linux-kselftest@vger.kernel.org
Message-ID: <66291395c0468_1a76072943e@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240423185305.15fca2b7@kernel.org>
References: <20240420025237.3309296-1-kuba@kernel.org>
 <662526f58a70c_1dff9929430@willemb.c.googlers.com.notmuch>
 <6627f699278fe_1759e9294e3@willemb.c.googlers.com.notmuch>
 <20240423185305.15fca2b7@kernel.org>
Subject: Re: [PATCH net-next v5 0/7] selftests: drv-net: support testing with
 a remote system
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 23 Apr 2024 13:57:45 -0400 Willem de Bruijn wrote:
> > Only possible non-obvious observation is that some kselftests expect
> > as root, and the ssh remote logic extends that to expecting ssh
> > root access to the remote host.
> > 
> > Would it make sense to explicitly add sudo for all privileged
> > operations, to allow for non-root ssh and scp?
> 
> I haven't thought about this part much, TBH. I'm not aware of any
> scheme used in other tests.
> IIUC the problem is that we need root locally, and then try to SSH
> over to remote. But normally the SSH keys belong to the non-root
> user, so SSH'ing as root is annoying?

Yeah. It requires "PermitRootLogin yes" in your sshd_config and
installing root keys.

It's not a huge issue, but if we do want to fix it, doing so will be
easier early rather than when more tests are added with implicit
dependency on having root.

