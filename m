Return-Path: <linux-kselftest+bounces-4314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA63E84D8F4
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 04:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7EAB24C24
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 03:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9DF3C47A;
	Thu,  8 Feb 2024 03:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BbjyjKNh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A9A38F83
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362342; cv=none; b=IVciu2OvOP0SOAbgd5+O/JAYBDYmgvSLiW+HmwGQWy1xkIbvZP8ODxfM8Dyy/gFNBCR2V8sYbit8dTxU1LEFZsZA10SWphTeAFV/pEgn3RHpJX6hkvZSCeLOgqMDOT6GP2iiGwZFxdIaOg4pCTpkLH039n3xcOHDA4pdQlYLnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362342; c=relaxed/simple;
	bh=+w3nNF6uogpeOgLKn6Je5uKi9bCs3moV2vFFqe7Bbh8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=Iox/jTilCtsAArxmx3P/D3Jbn5B++TV0lwkxx8KmlHf/VdtyTGmj+pueaQ4JxQd35doz5lEVFMYi+CXab2yoJBW58Y2EUwv/NYHgJar6nPoW3dj28NK7H9+PR7JlxNX7RVmvABsaVxlsI8ccfDzJcdcHF5MOFCnWGNXU6226oAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BbjyjKNh; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42c1eb66355so11927171cf.2
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 19:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362336; x=1707967136; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q3KhjY53aOKiu/8dSgqk45G/A+W+yYQLdqnafjFGGWk=;
        b=BbjyjKNhCJDIHDULzdrz3cMP5t5gjTQfPqZ4qw2zZH9jzGH7XOQSUOR+4ShxssiHKv
         me+rCLneCG5198J8hWoEX4VQPqUVhx8c595aKcRDLEDjPTmKVP02S96nqfzmAq65Y9Ou
         NWk0pqmz5ccLuh7xWJ3XC+r935s8TGLlGFFu/UCdUNLs6MUBq9aBu/UVPRfNif9MFYO+
         Ud5SI1+Ddn49eoyujsW0dy87ayIMqCq+oR5WNwKJGWMF5j2au6g6oej3bhNaqkilum/I
         WuljElJXHqkwYt/3/JkzU+uFq8N1YguZfoVbvvwlmAs98YaPyryAsFuSPg08Lt7QhSoe
         vGmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362336; x=1707967136;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3KhjY53aOKiu/8dSgqk45G/A+W+yYQLdqnafjFGGWk=;
        b=subqc1Aq1SeDiyRypBappN3YLzTGU/vfOmXJS1jE3DYwKKlTr+3miodgdvqBHyhgjh
         szgb4KukG8hwbsgeRiPXFuT6AkmP4ghXECBngIad4d3Q3PEZVtOuWPvguBHxBEmDVvRl
         SwdPBxEawC0QKZlgdlKlwxVpeO+sRhvIspXvVVJZOIRswaoPXvPzATA1yW90+07lF1Kn
         Hf0g4OlCvGo+oruh08jZRwzn/L/dXPhiCuWchMmGQ1dojVjjaVVs4cTJbda+63xDxn3Q
         IkePiNiCfQg6h8M99WB/VLr3OaKLRUnrxYuD7YX61mBm6K1PPJge52gLgmuh0dasfIvP
         isbA==
X-Forwarded-Encrypted: i=1; AJvYcCWaZWXzv/6lHMuLvPzp2vpRkuu6DwCZ0wqn0VmqQPxFY86545OVhlwP6YNIRgRHSzt709mUhkyNG5xRzYFFUwpNWi/VgKC4MuB2czqn8uBH
X-Gm-Message-State: AOJu0YzmNg4bcUuLUPgFVeqtiiHGbXjQYknl6vJbT8zo1k1IUEaF1DN0
	C1DSbIr9tsCupeDtcy3vL8UnFh9zVL3k5+Ky9vly7+jptupMElP8Tj4Iu9eWKA==
X-Google-Smtp-Source: AGHT+IFL6fTS6/mCqmxtrEurBQ1YLFaYPk8pHqOxQig2U4D4mABu+nKwfCflbWupUKFaexfjmEf5MQ==
X-Received: by 2002:a05:6214:226f:b0:68c:ae97:5d2d with SMTP id gs15-20020a056214226f00b0068cae975d2dmr8628414qvb.5.1707362336476;
        Wed, 07 Feb 2024 19:18:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7SeR66wpk7vEz605tS3+9PYtlauZrG75cpDzlb05xTOauWAwy4Wn9+jXkF75tW5kHvEjbNHcm2b2o1nOyKsggFYVhJDjvQY9NxaQBpQs5Kg4fePQ7MxHNDeAw+cFjuF+jnP/IrX6y8MyLmEI5ql2uwSdwv/bzVN9X2CXtVj2Af3Af2/7TvTJHTpE7RfhLRnq734aBmdJZWm/qCBR9X8n7mxmk7rsml08IdqkvHjvsv8BWXQr2JxNL/brtxVG0nzML+ubCIAi5Hgvl1HD7gxV/vM0xXiVU25XR6Nx2bXihTh9/K1WjFq6GmuBCFZ7G66Nl+DTYytQYUl1c1TxC5fjELwzhqSKkNX5Z/+NC40A+OAFtlnkWwjqsN4x+TbUGQg0Mxd4WiUOeUZo9HN+KnRRKq9Z/GWF3uXcqVVCrUMOifdmDi0YVKYnMPyVdjJ6mY807Z0Om6pTwCqgKeXSVB/BJFuN4nygX0Z2VU+CSAUpLdyOOFA2YDJocOz5QBwP+PuT3ELRMjiGYDobr9fWxvMRbBN/3XhRmnwFVuBz0MY/xngJQyq6vkA9lUjg7j7m8Y4SZlHfZo7P19l1FKdOCliTMUZ6G2IUUKlpVO5ovECcU+eLElDLgGHEa5mNEc/ZAFEd/eiOS3G3g1jq1OX5yNa88vwVjUdEjahb9uPLGXJjiGwUFgt6NLF61zPGLQUIYBbvPxi44m8RonkGQEIYw/DI6Axxcc/0iDVXYf8LXAkS46GNigfwtaX+c4q9upYbjhBYwFZXSGynEW4g80lhxAlXTYsPIxObPfJGGZbZFTC9k/dAH2m2dGt2T0R8fjuWsGq7ITidT963I4doJ2k4E59ecnU8RgTE0bNlNB3zlHRURuP8kgHQa2koxsiBCOkRpx5XFKkPXh/FNtUTQUhPmzjDe78M0bD13cC2NC+Wz3WtHe8uxdY8C
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id mb10-20020a056214550a00b0068cc0b46682sm893264qvb.4.2024.02.07.19.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:56 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:55 -0500
Message-ID: <e549d87d37bbd859be59acd4fab85b43@paul-moore.com>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 25/25] integrity: Remove LSM
References: <20240115181809.885385-26-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-26-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Since now IMA and EVM use their own integrity metadata, it is safe to
> remove the 'integrity' LSM, with its management of integrity metadata.
> 
> Keep the iint.c file only for loading IMA and EVM keys at boot, and for
> creating the integrity directory in securityfs (we need to keep it for
> retrocompatibility reasons).
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/integrity.h      |  14 ---
>  security/integrity/iint.c      | 197 +--------------------------------
>  security/integrity/integrity.h |  25 -----
>  security/security.c            |   2 -
>  4 files changed, 2 insertions(+), 236 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

