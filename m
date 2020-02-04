Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315A5151608
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2020 07:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgBDGll (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Feb 2020 01:41:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42677 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgBDGll (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Feb 2020 01:41:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id w21so3392470pgl.9;
        Mon, 03 Feb 2020 22:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=yaKe1siexgkghfuXyyVMtu7FqrPaWKb5BcT/yW/rvqU=;
        b=iu0Id/we7thuNm03dUaMlyf4jqnKVPQG1JuqxwLwkHPLkPJSyAMl/d9dA0g9eya/8J
         qWDf8vf0J+QM8EXG4cqHrZAZdVlXxybScgwFi8ZjCTPRps7RYVglw+XvUndPNVQupqny
         j1H67WjnJ8X2PxOc3XD7h8AvyNJ9BFaFMb8mVtuSC13XNxr5hON63Y96TvygYV+axq8o
         PZcieNKw37aQEcQRX14WfGZR8HGz+AewTQsCF6p/dR+dWX//G9LvCVLmemlTqEOX/Pz7
         vsNT0sTVX96pipG9y0uYGNjNlSPa74PNo6GfNhsd+lb4lzOuMvif2pCUGMyRkNuZNP7x
         GznQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=yaKe1siexgkghfuXyyVMtu7FqrPaWKb5BcT/yW/rvqU=;
        b=AL9CbbXJL8QR49dKiw4Uk/2Up/REv9nahabsTWmmtaT5W6GrOLapdzPcoHkQG6WvZb
         PWmeUUxckH5WQUuhoZwcBZ50Sgkw8NhXbb+1U35yzpbfLJPh4Ul7KGymm44bzg2AvpLc
         EvnsgCNO/iClds/bUvuZ8YMIUXaLWmaT68yEsvBtqIkJKjaQSBb3brgkqepmF+BFil7x
         jD1/zEdGTuX/KZe6HSPwm15NGzVFRJkNjBho5oVhsHZ+eJ4rFMSin5ZFcQe0ZmjmFAm9
         leDmj7wONiyWQCW/al/rCouwkTnKWSFRENjg4Mr7VAnkDaehQuqO4ray1EjA6do9RSCP
         gROA==
X-Gm-Message-State: APjAAAWeoamc7qWUAJ61loLL7qTO6IV3LstVh7JFcaoH6CLBoKfYouPC
        a9sDh7bM9tJruQMk8k4f53o=
X-Google-Smtp-Source: APXvYqzkD7oRT/xhxds+G4gJnMatFwe0kUy0+D+knfi/41Azmd6utM5/Dsy6nF0wRcwHVn4tzM+v6Q==
X-Received: by 2002:a62:1dca:: with SMTP id d193mr29801977pfd.140.1580798499088;
        Mon, 03 Feb 2020 22:41:39 -0800 (PST)
Received: from localhost.localdomain ([106.254.212.20])
        by smtp.gmail.com with ESMTPSA id v7sm22547213pfn.61.2020.02.03.22.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:41:38 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     sj38.park@gmail.com
Cc:     brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if .kunitconfig is modified
Date:   Tue,  4 Feb 2020 07:41:29 +0100
Message-Id: <20200204064129.4947-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200126015924.4198-1-sj38.park@gmail.com> (raw)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ping?


Thanks,
SeongJae Park

On Sun, 26 Jan 2020 01:59:24 +0000 sj38.park@gmail.com wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> Deletions of configs in the '.kunitconfig' is not applied because kunit
> rebuilds '.config' only if the '.config' is not a subset of the
> '.kunitconfig'.  To allow the deletions to applied, this commit modifies
> the '.config' rebuild condition to addtionally check the modified times
> of those files.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  tools/testing/kunit/kunit_kernel.py | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> index cc5d844ecca1..a3a5d6c7e66d 100644
> --- a/tools/testing/kunit/kunit_kernel.py
> +++ b/tools/testing/kunit/kunit_kernel.py
> @@ -111,17 +111,22 @@ class LinuxSourceTree(object):
>  		return True
>  
>  	def build_reconfig(self, build_dir):
> -		"""Creates a new .config if it is not a subset of the .kunitconfig."""
> +		"""Creates a new .config if it is not a subset of, or older than the .kunitconfig."""
>  		kconfig_path = get_kconfig_path(build_dir)
>  		if os.path.exists(kconfig_path):
>  			existing_kconfig = kunit_config.Kconfig()
>  			existing_kconfig.read_from_file(kconfig_path)
> -			if not self._kconfig.is_subset_of(existing_kconfig):
> -				print('Regenerating .config ...')
> -				os.remove(kconfig_path)
> -				return self.build_config(build_dir)
> -			else:
> +			subset = self._kconfig.is_subset_of(existing_kconfig)
> +
> +			kunitconfig_mtime = os.path.getmtime(kunitconfig_path)
> +			kconfig_mtime = os.path.getmtime(kconfig_path)
> +			older = kconfig_mtime < kunitconfig_mtime
> +
> +			if subset and not older:
>  				return True
> +			print('Regenerating .config ...')
> +			os.remove(kconfig_path)
> +			return self.build_config(build_dir)
>  		else:
>  			print('Generating .config ...')
>  			return self.build_config(build_dir)
> -- 
> 2.17.1
