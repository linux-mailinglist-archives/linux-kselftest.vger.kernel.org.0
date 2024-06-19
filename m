Return-Path: <linux-kselftest+bounces-12261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8990F546
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 19:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0E628381D
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 17:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9BE15572F;
	Wed, 19 Jun 2024 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlexAPjc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738513FD83;
	Wed, 19 Jun 2024 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818715; cv=none; b=T2/qbn2NzYJ2HhyN1UrIss40j6sd4/fkuxkOxUq+c/RoXsmC3p/hU965hHmOOTImISoNae4f4JW6KHB2tBhq1GqRekyu5hCTPQIRbXN87ArBUKOnEx0sxBZUkEhJ6MLStJsJbB4cY5eyjVL9JP04Nf3Nf0ZUsWQCB0qGSn3Wcr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818715; c=relaxed/simple;
	bh=4yMlmNu3E4RPfMYi/vUwCHzrd3B4Imj083hU/YUWekI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pm1oHGYfbew+Zm7pFWi1Uv6+hv5kVuVKaaz6Y9KLlFb0C/+XbOq4Pw7vvmlx1QEA3/aJmbGjaPSZ2k2Z0Y0Q8dZPbxVkkWvNl/hhG2evgdT10/PfXnMKeIpc8RQSezUTIku/WOjSuSa7orH+qn/E7/e0GSkcAAfdr2LQL1e6MZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlexAPjc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-70df2135426so30689a12.2;
        Wed, 19 Jun 2024 10:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718818713; x=1719423513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwlqRmpnnTbOA8a/YYpeWoQQ9Oj2iA9/yTutC9gsceI=;
        b=RlexAPjcA16POJxXvYNTfUD9xhKzcTKKLLy69876NfLLJcwQU1wuxc2NOQWvyttss2
         IariaH4gpie0wGSDrJvHrMBEbsCD2hc10va8x4WATC7wnw5X1ijc71uQZgYGosXivkbp
         dSeapBmOqkRXvT7ECZXSzA4lcworRoK9tzIsyTre3SDsQYUUOyN9S9bZrRb5rBoTXddi
         2rBZ73IIHz7Gze65LKkm7YdwkDuIF38sv7oBhCPetZ9rXSx8tCaJzHrGc8nyGCKebmof
         j0Vheh/lw0Rm0557596VAFzC/lXu6B9LXKqwYrr9ocNtkh6PTbKEmkFKyknIi90/yBXf
         rLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718818713; x=1719423513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwlqRmpnnTbOA8a/YYpeWoQQ9Oj2iA9/yTutC9gsceI=;
        b=hFtfFoikKQzdsAlVQKGK0LkAzR9rCxv4QiyBSC6pi1x8ohzVLN0syfK+0nbOO1NFxs
         Cuc97qktERwIXh2MsTe2WW5zljj3WH8Y03rZZkKO80+bbWzMQKONPxITj6arv1aLdfzc
         vINQRrX+Ksar0VRWyoC+YTQj2GD/oL46eGBR3Il3geYUTcLYprwTSjzRr8hykQCMt4G6
         sBr2Ls2nPHpq2uMsiTRpg4JyzL96jBAbUlLHf9+6PrFo0+r1Id2X2wFS7ye11dabzfny
         zG9vbcf0vsVLQeuEqhDPPX2gbg9XikTby9KXTuHBbPzHdrEWyyaE+oGnGfasS4RSxmti
         910Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEN1NHk/dmkme5Qr+VI2qtGbfIDRJAo0lXr4Or9v6/1A4DKOBWs5z40CLPTPurl8xuXA9ThitfEGKc+jO0aX8UhuHh+sbDTAKCXj4Kisj9qGjmRPvBYTw1araDQJbfiOsjfkO+3D+HQ92cIwJ1qH2TQ7JkxJhuaal4D2SN6blyWb14dkqdxHMydXlJ3SdlsIlQjNyXywCkomuzUyxYaabNqA==
X-Gm-Message-State: AOJu0YwLpKu5gvpAjdFZs3vBxaZ+K9Kg0LsqBES+epzSpWZNljqKoJ9y
	wYS7Q1Q95+pTTLB8K3zpSJXeqs+j0E3IqDpugkcem1cX2DkVjNvf
X-Google-Smtp-Source: AGHT+IGigk1SJQVkobXkIRHmXQvXlqqaw2Y/3/XxAO+442rp0W/fQMCjhA8liZPY8oQLO1GaOnawTg==
X-Received: by 2002:a17:902:d4c1:b0:1f6:7f8f:65c7 with SMTP id d9443c01a7336-1f9aa3e9e54mr37915675ad.26.1718818713403;
        Wed, 19 Jun 2024 10:38:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f01a26sm120205105ad.199.2024.06.19.10.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 10:38:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 19 Jun 2024 07:38:31 -1000
From: Tejun Heo <tj@kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Xavier <ghostxavier@sina.com>, Peter Hunt <pehunt@redhat.com>,
	Petr Malat <oss@malat.biz>
Subject: Re: [PATCH-cgroup v2 0/5] cgroup/cpuset: Fix miscellaneous issues
Message-ID: <ZnMXl5mS5zUHp7rS@slm.duckdns.org>
References: <20240617143945.454888-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617143945.454888-1-longman@redhat.com>

On Mon, Jun 17, 2024 at 10:39:40AM -0400, Waiman Long wrote:
>  v2:
>   - Fix test_cpuset_prs.sh problems reported by test robot
>   - Relax restriction imposed between cpuset.cpus.exclusive and
>     cpuset.cpus of sibling cpusets.
>   - Make cpuset.cpus.exclusive independent of cpuset.cpus. 
>   - Update test_cpuset_prs.sh accordingly.
>   
>  [v1] https://lore.kernel.org/lkml/20240605171858.1323464-1-longman@redhat.com/
> 
> This patchset attempts to address the following cpuset issues.
>  1) While reviewing the generate_sched_domains() function, I found a bug
>     in generating sched domains for remote non-isolating partitions.
>  2) Test robot had reported a test_cpuset_prs.sh test failure.
>  3) The current exclusivity test between cpuset.cpus.exclusive and
>     cpuset.cpus and the restriction that the set effective exclusive
>     CPUs has to be a subset of cpuset.cpus make it harder to preconfigure
>     the cgroup hierarchy to enable remote partition.
> 
> The test_cpuset_prs.sh script is updated to match changes made in this
> patchset and was run to verify that the new code did not cause any
> regression.

Applied to cgroup/for-6.11.

Thanks.

-- 
tejun

