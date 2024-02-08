Return-Path: <linux-kselftest+bounces-4304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C995D84D8A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 04:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748BD287001
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Feb 2024 03:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6537163;
	Thu,  8 Feb 2024 03:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DCrtUz4s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E11D6BE
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Feb 2024 03:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362331; cv=none; b=m9o0eZkSxvnxuNSgNKEDop7Y1FUQ8lCIYF7TuDzzIsJXvMh3gzYNUWb7evgdY1rOWlc0nlSHGcegC4MCBzV1G9Lkq8SM3A7vUj7vZSrv9UkznT3wQ0ktEfZRJfiF8h5EnYvToS8fpd0cmcnS6ueyhsCB/1Dw6rxe5a0pw7RLNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362331; c=relaxed/simple;
	bh=wNqqnpiWihipN1dNDa3R3CueTKA9HqfAdngEnTXkecM=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=hAHoc1C8zqR00JzrH1gtwuknlUz4sCkcX5TKK5Y7jnQ87Au6n0eqQAP+Nxfam9liJYjZUogOEqcIHbRVoiL3l2A2paHiu2JUQmi79vODtsEthSLdEdgmv2NFjpeEWZKZo/m0FdhS5rVK0+R9qR5rs5vzcZJrTwlxFtGF2AQmY28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DCrtUz4s; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68ca560ecb1so4912156d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 07 Feb 2024 19:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362326; x=1707967126; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UIu0ZaUnnX6YtAPfQYEsJ1lwfXBxkEp2fAdgZyQneCI=;
        b=DCrtUz4sRefaAumqYTbv+CMqt2xVHoEmbvcAObYHOPEQP1aVGFzR80DuKz2kiY7cLE
         ZsNutkdA3avqS81bMmfhAy/9YVbJGAkUwBTVfzxPc1rsvIxYehb9Ilcx5uSKYirS910J
         M9OwiqX0mbwNDzYVGOrTf6/VTlhtLSzAmNbijGDyxO5aHB3XtkVPXPO0q+BysZ4q569Z
         ym+3XbuYT9MYBhuqH4nkFL/AOxh2ZDNCJLrJAPcwVHbqollckcQ4bN5QbcuynIWy3vYD
         jV/Btcq0nFyvDc3X944wzpptXljiJykGnXda9HN+mD+iFAbP1LkaOW5t7xnZJsnfy8wn
         RB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362326; x=1707967126;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UIu0ZaUnnX6YtAPfQYEsJ1lwfXBxkEp2fAdgZyQneCI=;
        b=GRbBsG32ru6GvkzuVSKvL9jbwe5JJYQoiocc9NsT+qia0vJajWVzyaIylUJeBbtBeI
         skqx59UHnkc99j1v7RTeMgKwVQQjAutfJvAXcUCAnGNGTxqNZ+EErobgXtOnZDsb6FLf
         5F1IihYk5GtiSqZDC02/Q5seq73i2EB/hv3UqbwNZB6gbP0zTs3fXG/NWuv5MsNBbcne
         PNeViF+r3yR5agiuNfVZ00z+tHEYgnonpk5xTBL2gdFSqpJOQdkI1XF2JNJQ2/bOy0OH
         /jfU9VA2Sv5hOab1pFuDk1X3s/U/1al8OdBwss68YT/aY/hUZppDVFXlGvGE3pv0XVnE
         iOaQ==
X-Gm-Message-State: AOJu0YzQ8Wuco0N8CRhWe1YAqd/MnTXplaf9BmAMu3yG4zfeM7ncv6xs
	FUp9K3S+hA/OWUjD8Q9UTVePtemxaEUmbm5PGf+3UPkp2N7OuQudCIyEZYixtA==
X-Google-Smtp-Source: AGHT+IEhJln0zcQf1S08GOgkV1W/WrTHB4AJdf/zgTRT2S/5+8oRh4MhoXOBwicz3sZYx/icjN3ZrA==
X-Received: by 2002:a05:6214:248b:b0:68c:a9fb:9a35 with SMTP id gi11-20020a056214248b00b0068ca9fb9a35mr8514998qvb.25.1707362326422;
        Wed, 07 Feb 2024 19:18:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW3vLP2DzPsxe5CPp/nuqmlQjrzXMqjvyd0PZR6b0/87kWafj0l/GZArG+OpR7Oa8FXH6YnzrM4U+8Z1Lj+cLFjyGJmyXnwCIoIMZWGiPhFBLhsLH74dJznKwOC5yQYB+F7orvR55G1+TDtxFNzGQaHDbsIo7dmXQmZK1Gw1eCHRSYWGnnipAIzZtOr+zTsOTYR8p6a2+YtDmyZJawq5E71HRpdyPUWb7l0Titq+oo46PU7Khr1m08pldHJCndsHFKnxmLJ45vKnQCbFJTnvu+mU+nY/SD3Vv+Zccnd0Ka79+wxFHcH9dGJCVkNzIqGSGKN1bBRjDEAyHuWgmMEEvNgUr8eZH1Wngxw+h1BjNLYHTc6QRQIXX507/GoQgJX2CwdQ9Spqzc1sSy/RfA9Xp2SPlruVNi2q8HB9gSfUZS8ybxKGVAB7Pu5yNczuq+uCxvWv/z5mmPfg7zES0Y/HgfAn1fFwMkktPtM5CPgImgN+GLGuMk1laQpTvx6wsGBGt3IHQ8Xlr9deukycQ3ov+60JesZvSm7Mwtut5bTKbd+hXq6FjNZVny/N7SJa34ejx6L+ixOUSLWaulTJORCB9bAYhnSrMwb1ettNMz5B4xc8p/q7medOsz3Wsit6BImZ/cet7p9n2H0PhY6janIFrbTlwKFrIQtCftnqdaGq0sSD1JsuNSJtvsvSnptuXIpxCjIO2keDyftFImnShL6NdeMLH2n/JDLjqvY+tnPUcXcREBfI7XUMOxnzlQdXvlvi3ycwbUbk2/TdspqWq8BqPtxnndqt4f+i8ePuoJh8xNfDyrmwftSaSdK6oawf9UC6A4BQhrWHxO1KpNP8ntts9cfSriKgG9SPt0i3Xxc+J0HZbdDtgpxV0OqckzhVo+P++pu7k0eqEcQkstxTEoIzPvFG+RZ8VHiUCi6yIJKHqPYIgiV64kt
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id lx16-20020a0562145f1000b0068c510634d1sm1174533qvb.108.2024.02.07.19.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:45 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:45 -0500
Message-ID: <79855e97499b7b03a410a5e47588b463@paul-moore.com>
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
Subject: Re: [PATCH v9 14/25] security: Introduce path_post_mknod hook
References: <20240115181809.885385-15-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-15-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the path_post_mknod hook.
> 
> IMA-appraisal requires all existing files in policy to have a file
> hash/signature stored in security.ima. An exception is made for empty files
> created by mknod, by tagging them as new files.
> 
> LSMs could also take some action after files are created.
> 
> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/namei.c                    |  5 +++++
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  5 +++++
>  security/security.c           | 14 ++++++++++++++
>  4 files changed, 26 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

