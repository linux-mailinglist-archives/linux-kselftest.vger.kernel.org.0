Return-Path: <linux-kselftest+bounces-45365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D1C4FA25
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 20:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8A05189DA45
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 19:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079B330B3A;
	Tue, 11 Nov 2025 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keUp0W7R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7A432A3F9
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762890297; cv=none; b=nxrGH9MvdxtTCJFXJ5YsIyioU3RtFX9M5eOXTsgNrIGfU3ex/1kc5seCmb/nxfKsYaOD/qjUt79hnUjVkvNxjSipCu9EXzFamEVzaWLoENoMQrWug6c53yEgaewWktPbRmGmxtPgsHhkepUH2w3tS4sKD++tcetF4SKscma7xvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762890297; c=relaxed/simple;
	bh=7oWpdWjh8bUsjMbqkolVny17Ncf5rKANuor1AjH+n/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsYlIEOdBcTCTImo+UloMdThmJ4War9jmeeH/fMA4GGaVrVix2YcdFyTSGuPWxjXHlFIhzEKm4+h2Qp4/K5WSkHoLMyU/xBupRMDa3oz8yBerKK/myLpAuOnaF3n34peevIapOhzh3lgpF7IA29OrLVJvtBQ++Z8tZ77NUpkKCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keUp0W7R; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b3108f41fso16428f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762890294; x=1763495094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vL8T6v//WK5ms8HtdFj+QIL7sFTl22SJ6QXIGnOjBo=;
        b=keUp0W7RWwNrWaLT9DesESq4xUlrgnG73P1bYhcACh+Ay3B0aLJ0FJGx1xRtwZvWtU
         yeaOfE+OVLk/8quh1jcBWAqY0lBcoSgCSvdH46cY5+hBaLWtmf5RB9XzOBO6txhICV7y
         iK3hZimEXtl2JCqNZ+sGKK0MpOjew8U1wE0yaXwS4aB7zNNyEtWd0IhXr3x3jYQdFbeG
         9gQAfIfk5GuQH/tsG3P8VLhj6hw3/nGUqYS1KHEiIAnGTR2hWZLg8CjLF4VyCv1xGx73
         X73WjRkb8vWVwoQcKnUr0+IG4rCujwDuZQk3bJ4iJ8FABS9pqvcE5kuYvqkB446rpW4M
         OGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762890294; x=1763495094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vL8T6v//WK5ms8HtdFj+QIL7sFTl22SJ6QXIGnOjBo=;
        b=naQG1HrQG+I+qGhE4xJeGhfaHgmQ6fyX0AP9JYJDEYikpAaJiyDIn9JMFapE/YFZia
         FIeS5sJEz7+GOSTbeAhiH3Um16wt7lgTXev4sbN4XUVnsfDzd4PqVYSvtfAxw3hr7Q3z
         Z+hYB+q3Sdpy5s9uiW5YCvtlZh6a5spSNG0Qrbhmim0VuQlN2wlMxsgjpFmtme5j3/ij
         dmBcbDwgskk9wvZ4/Qx3HwUTXhPk5WiGzjwfKLYq/Yl7blpFhWPqt4rLBnBJTzXjMgCC
         X4XTA75UvB3lyVvbqttTg9wpy3IQY7RTE7VqzVVzhXHHjFVGtfD8xGMZdO3SdL/h84z+
         FThg==
X-Forwarded-Encrypted: i=1; AJvYcCUVCUJpsuuNw+co9Szz0pQnZRPET0uGV+IGc1SefQnSUK6jhVNptzLeKiC2ugvBpLtdU6BdJhzY26MAvWb6hyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy//TIFsukTw+ysj/oEMszzgUUtchR5kwMhG+G9vPjawxrKLlCt
	yJ8teC44qagwwQLMcFvV+e2Wd6PnG2N2/iFUJlrJeYcdNwcquLFSdetv
X-Gm-Gg: ASbGncsk11588GCuzwwV2gnDpTT+AclkKORBwZNYydS94msKkDhabhzcDyjuOc0Tctr
	nHjFcUQDMMgnC3IvoLpO7w4Tw9KzDKuI3lyj6KTPPAIYg4b3w4g9p99owqcWQzuj1fV+7OOliMB
	VJtC+paMEO3+j6hKNNYN5KEXUUlWC6zSGVs4HeigNrtHPKWkRFXyinlEPSDS2Qg6lgv+Gi/TXOG
	nKK61Ry397tIDAvS/hE0X0eHbGODVYH9+pFRModswhFXKRt8VzdYBy/IIvPH94IAisL1bRC+NLJ
	XTT0beBir0oxFP80nWQ/aOEdpGTtqKf5elF3pP7bSxiVDuMr4Cunr4M+CqYNZA8Q6EZO2++8sUP
	56cWJRC7t6gnuZkc0G6iyVmaoCvOMSPzon1E6+m4l6rT0DAxUOsriesHHTHSbPLS5T8oO5JGi
X-Google-Smtp-Source: AGHT+IFaIln3yiGIh9seHXdbbc3BGtrHgn26mO1mY0X8kAuJekH79JQX+ckG0i3gu/pYK/9GFm+SlA==
X-Received: by 2002:a05:6000:2509:b0:3fb:aca3:d5d9 with SMTP id ffacd0b85a97d-42b4bb8ed31mr286811f8f.1.1762890294369;
        Tue, 11 Nov 2025 11:44:54 -0800 (PST)
Received: from archlinux ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm28841586f8f.9.2025.11.11.11.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 11:44:53 -0800 (PST)
Date: Tue, 11 Nov 2025 19:44:52 +0000
From: Andre Carvalho <asantostc@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] selftests: netconsole: validate target
 resume
Message-ID: <nb7mfjnisgeenoazh5wi2e2twt5ooxfg225oqq3tuq5iqezi3r@mm6z3s4npsrd>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
 <20251109-netcons-retrigger-v3-6-1654c280bbe6@gmail.com>
 <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kv5q2fq3mypb4eenrk6z3j4yjfhrlmjdcgwrsgm7cefvso7n3x@j3mcnw3uaaq5>

On Tue, Nov 11, 2025 at 02:27:53AM -0800, Breno Leitao wrote:
> > +
> > +	if [ "${STATE}" == "enabled" ]
> > +	then
> > +		ENABLED=1
> 
> Shouldn't they be local variables in here ?

Yes, good point.

> > +	else
> > +		ENABLED=0
> > +	fi
> > +
> > +	if [ ! -f "$FILE" ]; then
> 
> 	if [ ! -f "${TARGET_PATH}" ]; then
> 
> > +		echo "FAIL: Target does not exist." >&2
> > +		exit "${ksft_fail}"
> > +	fi
> > +
> > +	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${FILE}\")\"" || {
> 
> 	slowwait 2 sh -c "test -n \"\$(grep \"${ENABLED}\" \"${TARGET_PATH}/enabled\")\"" || {
> 

Ack.

> > +		echo "FAIL: ${TARGET} is not ${STATE}." >&2
> > +	}
> > +}
> > +
> >  # A wrapper to translate protocol version to udp version
> >  function wait_for_port() {
> >  	local NAMESPACE=${1}
> > diff --git a/tools/testing/selftests/drivers/net/netcons_resume.sh b/tools/testing/selftests/drivers/net/netcons_resume.sh
> > new file mode 100755
> > index 000000000000..404df7abef1b
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/netcons_resume.sh
> > @@ -0,0 +1,92 @@
> > +#!/usr/bin/env bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# This test validates that netconsole is able to resume a target that was
> > +# deactivated when its interface was removed when the interface is brought
> > +# back up.
> 
> Comment above is a bit harder to understand.
> 

Agreed. What do you think of: 

# This test validates that netconsole is able to resume a previously deactivated
# target once its interface is brought back up. 

> > +for BINDMODE in "ifname" "mac"
> > +do
> > +	echo "Running with bind mode: ${BINDMODE}" >&2
> > +	# Set current loglevel to KERN_INFO(6), and default to KERN_NOTICE(5)
> > +	echo "6 5" > /proc/sys/kernel/printk
> > +
> > +	# Create one namespace and two interfaces
> > +	set_network
> > +	trap do_cleanup EXIT
> 
> can we keep these trap lines outside of the loop?
> 

Let me try to do that. I'm using different handlers depending on how far we are on
the test but instead I think I should be able to use a similar approach as you did
with cleanup_netcons() in https://lore.kernel.org/netdev/20251107-netconsole_torture-v10-4-749227b55f63@debian.org/.

> > +	pkill_socat
> > +	# Cleanup & unload the module
> > +	cleanup "${NETCONS_CONFIGFS}/cmdline0"
> > +	rmmod netconsole
> 
> Why do we need to remove netconsole module in here?

We are removing the module here so we can load it on the second iteration of the
test with new cmdline. This is following a similar pattern to netcons_cmdline.sh.

> Thanks for this patch. This is solving a real issue we have right now.
> --breno

Thanks for the review!

-- 
Andre Carvalho

