Return-Path: <linux-kselftest+bounces-4297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBE984D87B
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 04:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAC99B23F2F
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 03:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0502E62C;
	Thu,  8 Feb 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CwOBYXWY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCDC28691
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 03:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362325; cv=none; b=Ux3cKs+0SuktQ/JraARnBiL02euG8aV+QtOMQooVlzHJJ8y1xBtVBE60rCJurOVqHznh6oqdcD+Mg+SgxfOFxIMEhu8zurCF5+3cXumd+Vp9uOKjswkX+7Ygp6dd+My006xikAcCwxkZd1x9aEOK+2+Heqm84Sjomz6RjvaUZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362325; c=relaxed/simple;
	bh=6dQGPNZAgQk3XqwfbdpS8WaIUWpphTPHXuoWY2kkp00=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=XuZ1mRSEQwHSW5h1DvNx0FPLcWZuzKeXNjjLwtZziwPsK83BJ2gL+1cGTzQ+J6g5p3oH8IFx06S0k3GOt8i9mHfL5SvdptTqg0QDm7UqE1fTNENjTeLdr1v9N2onst2Y5J4zNvAif+2tFxqj3WXtP53fDRVEKoniZfy4dx7j91U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CwOBYXWY; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a4516ec5dso9585781cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 19:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362319; x=1707967119; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIE1KqS+DFaPo+w+SIvDjHcTCcgNUuxxYztbzhygZA0=;
        b=CwOBYXWYNQ8tEceluNkWygdecyKi9mGchAydIkqn1I4ollSJEyyEL5lwcNOh8ORbS7
         QmNWczi2MC2HXxQamFDMS+d1YsTGF1hBiNRggOriXcHIYZxgJsVCG8dM5BSi6A6Pa9s5
         9mcBMJ2TYohc4+Os8yzZyjki74Av7Bn3wEucnOcK+3IeoAeUb0Yjr8g+HdSitl7GKfpI
         AFKIM/JgDKDMFqWyMl9hE5k/0Z+6L03EK017mud6L8Q9ugUW/CPKxMROkasur3lvoRhv
         bsAMTaxZqZTfKe00FWeuG2c6MaGbGppW8npUQtzzuETEPClcz82T6MM6UcIw5Rrmo7dv
         ypIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362319; x=1707967119;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIE1KqS+DFaPo+w+SIvDjHcTCcgNUuxxYztbzhygZA0=;
        b=YBAUysiGA/0DX5fJ2zbZ6X3P2JNFQ5HMaNjf7ZXF5mlzOtxBMGssfMa0Rfy9PsYFBZ
         hlVRoSa+tGwwNCqCEgibrzJNlGgfVQzr2zzf19Yj5XzIATEpx0D47c9KB7XbNrRrKhp5
         B6VV3+otUcnZ50/OM5EjqoJBz7hBYaVb4iWWNoXin4xNWc2ZU3yeZt/K5LdbbNQlnAE0
         ZsyU6p9I0y/1xC201As+WpJjIPf4S3tMHZmhNQdDT3KRxZ17kbOtXLJFENXeSpwowTr9
         R2EEdX9Ak0RSuS2FGDoCVsdJo8K4+gyuAb8GptSFSWa+ZLrAFG00e6+9zS1aDO0tYKaK
         uamg==
X-Gm-Message-State: AOJu0YzJGoUGvapRwKNs5hgZ2omvCB8hjCTAUqWrrjVgec1Pj3/rXBcU
	JyGnFqdV16BI1GP5YSbiIb4kt1oKOmeDhGWjGebpz7iFqKeFn9+Jzq1bGmHhmA==
X-Google-Smtp-Source: AGHT+IFvne7Bagt1y/fBeaIYwsrRlH1roQNbxteUXkauL/JbBuOFzXm/opqXKtoBBsNWZEF2BDgS+w==
X-Received: by 2002:ac8:5c83:0:b0:42c:11a1:8fe4 with SMTP id r3-20020ac85c83000000b0042c11a18fe4mr8112819qta.3.1707362319505;
        Wed, 07 Feb 2024 19:18:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWEUxIofwW74PGyoJ8FY1IJnu1uB/xuv29qq7GOkQQ3bLxYm6RvZoEXg7eMOUuEMPvUG5hgf/Z4umMIn2eFgTmQZn8yda4w1M8/17yTq6fnUACj2eYNw56eZEtcXkKZ2KfL1mvTqpMQIVqEzBLXWG+dRTYb+4C+jXEo2D5enqPxWWSl2r7nTeKLB76/JaB7COL/nbG9Mgt4xUPYeTZi3Fg3q8ZTTM7u1VU8+FqFwLIWiwk7mQp9lcmu5VTnmutOGLNLhzLqVR4jwJIimhBQ5jUW752kH/qa4/8piifOWpCIHcglw0kY2h1t/vHw27NOAgYmtoq6+uCacw2hwrZA9rNBzd1l3hdoz3TVcWC/fi6ZmVkOuEoxmMMChkikmvGIE/xBPSa11JP8nO8blMM4dwelWjXGk27aF7VAUC1eegwOaM2Q/WhnN/TZ+57QNdZceQlk2E94WzI4jJ+i8oPs8oAB4+BssO7wZhtT9VNOosqWWeEdP+jXQLQzZtJAooAZoTX0fN9/JKGxclSQDqlaYd/zA9aSU3T0TroTKAokjQE7G88Ru7REBI1ei/DVQzkGguzKGJbw7Y881w0hRSyFF85ZVkIovYPfLzc1ryq+CpoQHPdqZq5JsyNOyTla/EWZfMkScefkhtHeCEHBpEBP56q8ZzxFfU4+GFu/oVu5wuUG8EWyqvTiSw16BwDzNe8pXNnE+7L9qXrvNFijBuSdA00fTzhSZJR3eWHGn1BZm3mRyGiE71/GKzhvg9TuEDcZKZNBo4f+R9u9UPFDRlRPUp/9x9EXNER6kMYupk9+d/3bAAmBi+LPwnHXoeCuraN6jkzE5qzQpHIB89/lHNzf7xE34j7HF74znCHnsEZ/hgK/rvXFhvrACLk9XHJC6kVC0wHFuTos+lE+2UWtJiqGlTSk64WreLBTTtTa5ptAnIAkrIAzDWuffq7vNvEI7k7rsnI6DD
 49/ehc07WXbTQ=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id ir8-20020a05622a6dc800b0042a6e6792basm1051838qtb.69.2024.02.07.19.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:39 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:38 -0500
Message-ID: <9f9fc3a959c74bbe51660656b632ba25@paul-moore.com>
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
Subject: Re: [PATCH v9 7/25] evm: Align evm_inode_setxattr() definition with  LSM infrastructure
References: <20240115181809.885385-8-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-8-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Change evm_inode_setxattr() definition, so that it can be registered as
> implementation of the inode_setxattr hook.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/evm.h               | 4 ++--
>  security/integrity/evm/evm_main.c | 3 ++-
>  security/security.c               | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

