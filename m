Return-Path: <linux-kselftest+bounces-4298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C678884D87C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 04:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D771F2366C
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 03:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4942E633;
	Thu,  8 Feb 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YNYLQOie"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD92B1D55F
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362325; cv=none; b=suuEe22SD0EkrrOzU2B1OvppYjnI2F/nc7emWMJB4t9d4c8u3eiwdASgfO1pOIL1F/Voal2VztIrbstw369aJ06zhvLIe3N/imdtNsJPpvi1bF5ug5yToTdWuv0OEny5Wl1OykYVFUO6aWuf5Zvl/RlknzgwxXQT/cW6sRzpVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362325; c=relaxed/simple;
	bh=geS3uhgfJdunV4nVLQ/ITMCCZg/0OQfPAT1tmDfbG+A=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=Oms5DSYaLU6wnN4CrfB/5MT+toNC3nmdj7rCiuUaBT2ISwqJc7vCVMUvojbhwR1JLwqrbDiLVPywMnEL6krfVNHFQcnGNfIo2Vb594B44SW89Pn7FVuIKp8fkGRuj/Twc99C03NJvsTa3d99cWCJaEVX25fHDlFKyYcz1dqPEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YNYLQOie; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-429d7896d35so8331851cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362320; x=1707967120; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f9a68xK47oRXllyR+mnjvXvrpcakKcNUJFmQMtWCIHE=;
        b=YNYLQOiejdFvFk2r1ZV1UXTZJC0D2e3KmDA5v4fUdMu/iJIX0QkTonk6MIIrdWUGoc
         GsRkjN2M8F7TVEy6Q7wZcGQZl1CuNhz2R0y6HjuWqS8zH1CvVsn4WqtzsQP7cBkvHQ5V
         0tntwDzzKK4HraWdZjVpj/8K21gHw/tBcnP4dlW08EDWLsLxtk0QcAkgVE/kI1UCaH7R
         pxVykKF+92VKMViIpE+3fQr57P7McuNqXBGcEuTQ7PyBMT221n3RX/srs7lXYS/R2G2i
         62+m/gwVlxxpFEwqr7yP3fdzt1nqfwa6sE9lTaEXDGAnRqMwU26GNjmzTt3FzrjQDdLE
         Wy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362320; x=1707967120;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f9a68xK47oRXllyR+mnjvXvrpcakKcNUJFmQMtWCIHE=;
        b=YuSM7vt4olSLNzNuJjQarjVNsJGtN3hG5qQ8ELzwgcnUkZLe9hqEnzbdWcefrMAbDu
         pcfF1avLP6c1boIMD075JEgxHRbeJMkAwD8oWMkLvf5Zq971duA4Mveqj6MkrIqf6Ef8
         KhoOsN6v0D1qs1cG2ljauKxn5lpHCS1gcjHX5dL1kl02pDjWdPKe8TM8rLfk0eJYgnIe
         xmX5HQsH1h8f92HzL6Cmqn9V800WBqr2tVS113NInjgdnm9jOi4bdHryyBIspEDFNTrU
         LzJRk+0M5Th0gKczt34n6lMCsUeYorOYNKA5yipgl9h1OIm9enQQCN1eOmoS/H+Cdz0q
         6+ZA==
X-Forwarded-Encrypted: i=1; AJvYcCVpeDYgilO1n6B9VmGlTlnKUGQ5ObmHPlOt4UsOAlNgflAUtuzdqN7A4GXLUmtFNWNBtt0MyI+5Q7pH6Ng+/q6OD2l8RSmv+jOo6JF+AFSK
X-Gm-Message-State: AOJu0Yz9uCDcJQ2I3kJVjKSDWqU9Jb+cZvkDXTVwLe6DGPVMln7zjaZB
	zHqTXfCfC7HK9xTDdvXn7G/KR2TEKC1inSEz3dEH/JqGGYLmjXivFt+KrgT72Q==
X-Google-Smtp-Source: AGHT+IFzT43LiUkGz/EGAkpNY7i32M+6kZqMoZ4GuuvK+zDVfnYRSrYzSfvQH3ZaHpZpap80oTiqDA==
X-Received: by 2002:ac8:7e95:0:b0:42c:4773:c3d2 with SMTP id w21-20020ac87e95000000b0042c4773c3d2mr2492941qtj.53.1707362320520;
        Wed, 07 Feb 2024 19:18:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPPJ6qzORQCQTgdORb/FnmueS5tjB7vy2+mLdqZ77tLfgybSlSS9yDsKniHR7D5+wO64pv0YJTfh/l6GmEJi06dqeAc71+snxZp0f12Iun94nsZMnkitEUqBs8qw0sNQgFZUuYtfGqfWJxi9bpIQT/k3vGTHtZomQZGRaUZzz6akTP1r3cVqUpgOeo5ao+07a33CqUTaOfGwpHozMe/gxMc1uEwzbEdxKbNsPEUQPq8bHtTnU3F2Jk4TjlF5etWt1Xiql0VC1euGwjehOJvSqVttoDOYNQnQx76iHnuv9b63gUfccs/eU5PnP/Ax9Jcs2pkgAo5t/RgeEro7W6+Me6Ye3vkLvZPt/jJjUmPZXIyaxd+4MaM6xRCMxP0il6EySpoxhYPK8pLu+0cRaOcr2E2y7aFcdIpjf7R0tygmwUA0Cxc9M+wzDQs2AcP84r0TyU+zvQnxlB86/KAEbAXw7VFj4GJt5yAud2RKqSxj5Nki+cmpbchQeqc5sK0bdsOK0IP+MsEEQbfGYAHOAkExncGr5AbUoCf/sdFmbdHf5MaOQ7fC/uOdmWAsIUM7ycaMbc/PO6xxKBZK5zQTyjBAAbh1BqIlphdpdgk4INDpKlO1GtAdQPGlRRIMMHnFqEMiaA65w9fW1vg38h3NOCrJxLC13gwYLRbFzlfqTfdwmFGBFpkY8SdGvbGHx3LEGt08fvZ4mwns8zWr+asBuIApOyhmFDwRZRwBGcNF9nRkcqzD6UyFmG+eCqWTGqQ9xXHQ0G8gP/0fRAxgC67VXuYIXpnmpIg5nHMKnwJVEm4nY+8RrNQQhSsgrtr/CQQyB9gA/oYst7KHrh4Oql7Sxdprxq8NKtsO5zwOG2jshafYhlTHiL1hoXsp9QTHkWH0MYkI6LNOP1/9bIF5UXcRGVuf7pAtVX7qd4Xh7TP1Benu/oXB5CwgC13yAfSW6ri5aog6MO4A
 NLdA3ncI/3kzs=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f19-20020ac859d3000000b0042ab4a129easm1065675qtf.73.2024.02.07.19.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:40 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:39 -0500
Message-ID: <79289275487c2513371bd8dac5565d68@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 8/25] evm: Align evm_inode_post_setxattr() definition  with LSM infrastructure
References: <20240115181809.885385-9-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-9-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change evm_inode_post_setxattr() definition, so that it can be registered
> as implementation of the inode_post_setxattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/evm.h               | 8 +++++---
>  security/integrity/evm/evm_main.c | 4 +++-
>  security/security.c               | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

