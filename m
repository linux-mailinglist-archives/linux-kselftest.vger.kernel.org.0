Return-Path: <linux-kselftest+bounces-5623-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D125686C58D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 10:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 736C61F2266E
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B957A60BA7;
	Thu, 29 Feb 2024 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="MEywyQSQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3360B9A;
	Thu, 29 Feb 2024 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199550; cv=pass; b=ezpT2KvfEkr/Zyk0eJzMVqU1IaCBB6hZp9uZLo6GCRKHucX5JpZj1xgvnGBW9pdv1tXhmvSaUur8pXq0Foy7ga7yjX5Py7njC//WHUONXNE7u31GCLpkt/nZk4azsw2Y1WMt4p5JaLlV+pIvXoaS13msHR5WrroNQqSRrev47+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199550; c=relaxed/simple;
	bh=t3nLYlQ4xldl0KeA6oVmmLFGXQMGLRYPyiwEu2I5DzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqWvnX6nl4DtdW1+wA+QxCqyMJPrlCcQiMcoPddvTi5EEx/odtFOsEtOCDsDqL//7mmRIJJul+zPBZuR+6UjA9bqWNxRV4FF+eucycmQOPsdNnqrArl4DEMzBt2HIn/RJfHkTVhYLcaAcPmF95KQfXMg6dsdw5zsH61rziRSZUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=MEywyQSQ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163c.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sailus)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4TlmQ15ZNhz49Psp;
	Thu, 29 Feb 2024 11:39:05 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1709199546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ic0/mePXAYuU+/P4n2i1okUocpeoe9yjMTVvtpQYzc=;
	b=MEywyQSQpTvayFHEm7VgF6Q1jPzYfVwpJgHnhQ+80aICMwiMz+SAdJOxHJPc48VbCl2YzT
	JHgrBdJ5dZM3iTic5JqcfOk6Tcu3NiSbgctscZBbJ5c7kgrKbzquDdZjZ0S9jF2DLiF9wY
	Js348BJNeApoECHr2bT4+epOU8M+sTbw3CL19cVfDJEAW2bWOQFc35VlcXRrXgEzSubmx3
	LX6mR8zaHjq1eVrN8aDcUdzPhJKa+zjoX1BtAH42I8yzfAGLxAJ8nCaKNOTWxGSrWJELmp
	GbRivb8swqUtUL0TebrJb7RbiOCMAEA3LOGL36OnaNWFNoQTZJNmoJSWrrjmQg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1709199546; a=rsa-sha256;
	cv=none;
	b=TVYxk91G1WaoAMdK0TdxrWgj1YetMo7Erde/nOKQV89+0slr+l/ksLnZvuqaNVzEoVsIs3
	nA7nY9Zz5S4yblu4lkjJxrIUIZbsU6MpgNydshq3zDTOWaBJUD6ac+cXtla7YhPnxCMfUW
	sVdC4hEIPes7vFolsZVkPj/SM0LRrLocsMuJrL8yTSXdb55lO/efar5zVxaq/JKzjF2AcG
	xV30PX6q3y+yQjiqVf++q1L1DnTulOhvukKnyMtMgRcbKvKYQ6UaKY0Z8qoQDLzfGfcZXL
	IQHdDFSd3fgyBG/hEfUCPY+Hrd8p2ERDWCgpQ87Kug8NNBwNfVJjKWnMRVYjpw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1709199546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ic0/mePXAYuU+/P4n2i1okUocpeoe9yjMTVvtpQYzc=;
	b=i86L8G/Ci+lh3Zo4pzgDGBtqpV3TNPFa+APkSAP8nVqFwm1TMoQJK5vBqNNIn+NEXj4TF4
	H2SvxhnwtxS+Ivr+gKVEF0iYs5XtMB/CPrfcF5LS+po4Y80HJqYPfua/VNwJ2eZS495zXt
	NupFiKKo/xxemAcHllC55t2Md5F478gJwaj1Ld6pmekoqdOZw3sXrnNK7yZU9J6yJgdKJP
	KfmucmHIXvzOu9x/UOk6bd5cWtBzJNQgaElhfMoh+8uib+U3YURJ8t6wtoH2Jfmdk5Ukof
	/Nlt1BmUOkiy2LgBLEw3Hyv7EueEHJ+coYfLgMTB5q7sTmOWlSMBKBBdZxPiew==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 30FEC634C93;
	Thu, 29 Feb 2024 11:39:02 +0200 (EET)
Date: Thu, 29 Feb 2024 09:39:01 +0000
From: Sakari Ailus <sakari.ailus@iki.fi>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Helen Koike <helen.koike@collabora.com>, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, pawiecz@collabora.com,
	tales.aparecida@gmail.com, workflows@vger.kernel.org,
	kernelci@lists.linux.dev, kunit-dev@googlegroups.com,
	nfraprado@collabora.com, davidgow@google.com, cocci@inria.fr,
	Julia.Lawall@inria.fr, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/3] kci-gitlab: Introducing GitLab-CI Pipeline for
 Kernel Testing
Message-ID: <ZeBQtfY8FG_qtoEJ@valkosipuli.retiisi.eu>
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228230725.GF1659@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228230725.GF1659@pendragon.ideasonboard.com>

Hi Laurent, Helen,

On Thu, Feb 29, 2024 at 01:07:25AM +0200, Laurent Pinchart wrote:
> > **Join Our Slack Channel:**
> > We have a Slack channel, #gitlab-ci, on the KernelCI Slack instance https://kernelci.slack.com/ .
> > Feel free to join and contribute to the conversation. The KernelCI team has
> > weekly calls where we also discuss the GitLab-CI pipeline.
> 
> Could we communicate using free software please ? Furthermore, it's not
> possible to create an account on that slack instance unless you have an
> e-mail address affiliated with a small number of companies
> (https://kernelci.slack.com/signup#/domain-signup). That's a big no-go
> for me.

I agree. There is no shortage of good alternatives either: we have IRC,
Matrix and XMPP for instance. Just pick one of them.

-- 
Regards,

Sakari Ailus

