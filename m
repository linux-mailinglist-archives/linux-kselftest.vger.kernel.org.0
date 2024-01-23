Return-Path: <linux-kselftest+bounces-3420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC078392C3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 16:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DD13B26494
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jan 2024 15:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A05FDC6;
	Tue, 23 Jan 2024 15:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="XXbo1DEE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8faa.mail.infomaniak.ch (smtp-8faa.mail.infomaniak.ch [83.166.143.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF55FDCC
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jan 2024 15:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023983; cv=none; b=kAtXMpsxoKoCu03eywVwXKB6cANU4qWGX4vBAhXIzxh8G41D3e+pcQY/AygTobSzv1ICHX1vu4rMMflQkGG37GWM+1/pQIVT2vTChy0f2U+4wzuQeekjmhCAZ9wQzimNsf7+Sqi6Ubt+A3zNxIiO7RgII/RQBibMxwtpOIjjGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023983; c=relaxed/simple;
	bh=zgqI9UR8YogjZoN9u8vWb4dHmJvB8ik8X67zHyKWp0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A4CplaL0Nhlpua5VwjRKz8kmjVFuzeyeiUqgGtLQMN3D7mQhjWv1ACek4F+E8FxmgKyB5bk4vDtGVj1ryIn+BQiVucAo/29ljUt1bLyJYkRBlK6bSeV5HiVjo7cV5V51/IgTPB826dtO1bOTUjQhIDrpG5yLlPUAY2Y2jAP+eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=XXbo1DEE; arc=none smtp.client-ip=83.166.143.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TKB1N6n0DzMq5jw;
	Tue, 23 Jan 2024 16:32:56 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TKB1M6BnkzrB;
	Tue, 23 Jan 2024 16:32:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1706023976;
	bh=zgqI9UR8YogjZoN9u8vWb4dHmJvB8ik8X67zHyKWp0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXbo1DEEM3NL5OR6r67arzFI93BlDNA3jzA0bdkXrlPcz9PWoynqbZ9DRchI+s6Hg
	 sumZzKWpg5rsuUXtHAg+MW1vTX8Wek22Z+dFFd/K6v6792zx7BcdklDSFmE1Z7xIYb
	 udJuqxRWB40sTpRe3IUczKgQk87Ey5o7YLkGSRLM=
Date: Tue, 23 Jan 2024 16:32:52 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Huyadi <hu.yadi@h3c.com>
Cc: "jmorris@namei.org" <jmorris@namei.org>, 
	"serge@hallyn.com" <serge@hallyn.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>, "amir73il@gmail.com" <amir73il@gmail.com>, 
	"brauner@kernel.org" <brauner@kernel.org>, "avagin@google.com" <avagin@google.com>, 
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "514118380@qq.com" <514118380@qq.com>, 
	"konstantin.meskhidze@huawei.com" <konstantin.meskhidze@huawei.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v4]
 selftests/landlock:Fix two build issues
Message-ID: <20240123.deeT9hegh4vo@digikod.net>
References: <20240115102409.19799-1-hu.yadi@h3c.com>
 <20240119.Ugaehae2ze5b@digikod.net>
 <adec399e50c74b30b59480d92c431241@h3c.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adec399e50c74b30b59480d92c431241@h3c.com>
X-Infomaniak-Routing: alpha

On Tue, Jan 23, 2024 at 12:04:17PM +0000, Huyadi wrote:
> 
> >> Changes v3 -> v2:
> >>  - add helper of gettid instead of __NR_gettid
> >>  - add gcc/glibc version info in comments Changes v1 -> v2:
> >>  - fix whitespace error
> >>  - replace SYS_gettid with _NR_gettid
> >> 
> >>  tools/testing/selftests/landlock/fs_test.c  | 5 ++++-  
> >> tools/testing/selftests/landlock/net_test.c | 7 ++++++-
> >>  2 files changed, 10 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/tools/testing/selftests/landlock/fs_test.c 
> >> b/tools/testing/selftests/landlock/fs_test.c
> >> index 18e1f86a6234..a992cf7c0ad1 100644
> >> --- a/tools/testing/selftests/landlock/fs_test.c
> >> +++ b/tools/testing/selftests/landlock/fs_test.c
> >> @@ -4572,7 +4572,10 @@ FIXTURE_VARIANT(layout3_fs)
> >>  /* clang-format off */
> >>  FIXTURE_VARIANT_ADD(layout3_fs, tmpfs) {
> >>  	/* clang-format on */
> >> -	.mnt = mnt_tmp,
> >> +	.mnt = {
> >> +		.type = "tmpfs",
> >> +		.data = "size=4m,mode=700",
> >> +	},
> >
> >I requested some changes here.
> >
> 
> Could you give me some inspiration how to fix it? 
> it looks fine to me to assign value as above, which consistent with other pseudo FS tests.
> Thanks in advance.

Just add and use this for the two tmpfs data:
#define MNT_TMP_DATA "size=4m,mode=700"

You can also make the mnt_tmp variable static const.


> 
> >>  	.file_path = file1_s1d1,
> >>  };
> >> 
>   

