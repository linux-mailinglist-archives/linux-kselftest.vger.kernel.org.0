Return-Path: <linux-kselftest+bounces-12134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8025190C750
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4467928462D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32531B1425;
	Tue, 18 Jun 2024 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="awkjWf5t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC31B1400
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718700283; cv=none; b=P7G67BJTueKy/MruQwncOnpFdX/m8rdRWD+8L8xxvV3fz8A8gd2dnLZzG36ZooEkoE/5lhlY+S28W4KDGZej9a5k8wZSUNO45rUYGMbvlER32nKKUVogRMs0dafGtxR7pz4vCX3WcUE6sB9NFglp1dnhdeqojM+tA9Szhx5+gQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718700283; c=relaxed/simple;
	bh=mv7P4idE2zwjdwscL0C4cqMbkmN2v4Xjx6FUqbVC6iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpv5rq1bVqTHUZmRvsThjaTXnIX+dgILwt1zHKKevJpHHDTxflW5IAlDNp+TI58ujnDJOpoORC9ds0NZpdg00f9Lm0/9wyEqa53lj0xDHtqjLj/ezfd8W8w042XsyTsWjmG+7qRDW7Kd1jMHRI3uNQzUV+XOzTMyqSHleY76r4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=awkjWf5t; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57c7681ccf3so5973120a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1718700279; x=1719305079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nK2axCqPwPABo1otkncfWRRBuCN1IirP9neCmZ8cQvA=;
        b=awkjWf5tNE5HsTJnfNSHvDeBrnZCZM4i9oU0ur+CPrY1Dkh1XDjhpiRnn8si/QWUEv
         hJTGioQGNSLzx7PtNQp+/S/5rkER488wolEHA70EQWb64pKw/kmIpoW8t3SvZu3yUSso
         /WUIZ9ARq89zptjnRYSTmScABqqa+QLI9/9NpL5mmAoMaGtM5rRvIAojz7l17rnab5dS
         uj70QJJMowgGojxrrcHcbgicCOpEgRhtmyg12+yfympCPlGi7ZGy/I6ocgFExUrAtAie
         U6a74wkmS1RaVm+IOnHwR/QtPy/UWo5VAwqegpJDDjXKzYxOOT2IWvJLqItiy+amQedt
         pLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718700279; x=1719305079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nK2axCqPwPABo1otkncfWRRBuCN1IirP9neCmZ8cQvA=;
        b=rQ+jpeGvKtls5sGiUpnpJaOFZROg/F0iIGehlUGmPvCgYr/Hxw4xy7q/CASMSBRbpN
         hET2I/wZZH1PrGTH20FHGfJkFFu8OhxtzbnWfp5MU4LuXwJaufaY5ToQZlJKzZ0do32V
         1qqvoFvkItcV/nbcnMAmfJWxuN9Xo1eOTODObawqc+FpZkoVbhiI01IyuBGQY66+6z4D
         IDWp39nYGOE38jpFFehYWhuW8y4jKKIo65tdFsH7BgfkLaaGeMTvTUPlxnIn+jic8i+q
         UfonGK/JHdHxVwPq+dOuZLdggOfmA13noeKWeZX1xnMYqawFbz6EO+jviMCpOPFhY5LS
         /QiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL8cgdklS2ynO7EEPSwBQ2Rzjam7osW3xYxCKIe3itEXYsZqRGKyYoHRqz+jcapwoFyuQqUQ7vA7hLvL38ynA519G55YrLwpzBjuoZjEcm
X-Gm-Message-State: AOJu0Yy3pQN21wF7EzpYB9p7LB7F621XygOsRugHy8ewOMIdWy8Em1yC
	kYs9Wepap7414msohMvQVvkutI8KubUB8VlTjPSuO/ypLBjpCQRGmf/ZysFPpZg=
X-Google-Smtp-Source: AGHT+IF5emwzUb/jD+T+bQNWrywKXs257shi7gLMGlWOOKmQp0n5nZ4wRATqrb51OuSZuSMcaMUNGA==
X-Received: by 2002:a17:907:c713:b0:a6f:69ee:dcd2 with SMTP id a640c23a62f3a-a6f69eee6famr843958966b.57.1718700278043;
        Tue, 18 Jun 2024 01:44:38 -0700 (PDT)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f9bbc2136sm31093066b.123.2024.06.18.01.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 01:44:37 -0700 (PDT)
Date: Tue, 18 Jun 2024 10:44:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests: livepatch: Test atomic replace against
 multiple modules
Message-ID: <ZnFI4GHb4HA6BVNW@pathway.suse.cz>
References: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-lp-atomic-replace-v3-1-9f3b8ace5c9f@suse.com>

On Mon 2024-06-03 14:26:19, Marcos Paulo de Souza wrote:
> Adapt the current test-livepatch.sh script to account the number of
> applied livepatches and ensure that an atomic replace livepatch disables
> all previously applied livepatches.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes since v2:
> * Used variables to stop the name of other livepatches applied to test
>   the atomic replace. (Joe)

It might have been better to do the change in two patches. First one
would just add the "1" suffix to the one livepatch. Second patch
would extend the test.

But it is not worth another respin. I am going to push this version
(with the typo fixed).

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

