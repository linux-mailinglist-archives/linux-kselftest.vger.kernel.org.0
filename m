Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB23D6A1A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 01:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbhGZWhA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZWg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 18:36:59 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234D7C061757;
        Mon, 26 Jul 2021 16:17:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id f13so3072129plj.2;
        Mon, 26 Jul 2021 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lYRTOLatMvzufkXYQLuONyMUV7E9MEoEnSQSV7vItG4=;
        b=ukt/FXGXZhngCDB8sCyEf8mY2XOXpjHXXQIWNQOJlP53/6jrTbcUh985qo1v5ojigo
         3X014eLreM03cB0ysU3KMUG+Mujsn1Y5DgdC7zaLa6Mj+96YbVkESdw0dznKrXX8aAAB
         JzxRFhIYGNXGW6Elo8T/XVcPTKI3RNb06IWRonV6/phiMiu426AlLqdMwIzErsjRxgBT
         9PDSoWdAI7XhvD9sjaSWVcSOOYyzSXgo15dZL+J9vA9qYQHRantJ/QVMil6id/u/lYsj
         2OvKahQUOiSKhFobibcUh7jJDSQjT0M3N/b+QpSGjOb7LYEAKBT3j04vt8UMOwXl5flu
         qX2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lYRTOLatMvzufkXYQLuONyMUV7E9MEoEnSQSV7vItG4=;
        b=fBhALFhYDRVnX3tfUAg+Hn8Uv4sv584l0jtzOGexn1SWTjLBO0pwdIV1TS4pR1lJNg
         9vaBF1khPNg9Wg4Q3gomFh/FIsE9SBLmlsBTAsW7XNwU8un8prohm8k+UXNnnuJULco+
         izuxDjLcN5lR+WnWnX9G3LKIW0H1C5pXiQkQTvlo7vPpRZc1MRjUQFoJ3qUrUI8S2t4Z
         cHkimxrA2XD/qB0oTTu+sTDHDQL5qEGb/2zpUsWYtBsMVUw9otxTSK90F1lLvTcHdBQq
         17xLpkjnUf4po7iYdIM7JMFVf0HAj6sV1parnBpsoDZqjGCuRGt61BJUsTBocmCbTnt1
         /ZGg==
X-Gm-Message-State: AOAM532SPtSgU5lbF7gvFJ4+x9ZZoSdpGqUTEKULFO355WDBH5nG9To9
        C1DpDaGf7owUBi0YPE4OS6I=
X-Google-Smtp-Source: ABdhPJylm4SuAyERe/WNahzmUsTKLPhhKxWy0KJ+V8r7sfNaUo+0j+eGAxsTxir0Wd6WWFKmQLZj5Q==
X-Received: by 2002:a17:902:d2d1:b029:12b:adaa:e443 with SMTP id n17-20020a170902d2d1b029012badaae443mr16243294plc.1.1627341446473;
        Mon, 26 Jul 2021 16:17:26 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id l2sm1106807pfc.157.2021.07.26.16.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:17:26 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 13:17:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Subject: Re: [PATCH v3 0/9] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Message-ID: <YP9ChFvrGrDMGzbe@slm.duckdns.org>
References: <20210720141834.10624-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720141834.10624-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello,

On Tue, Jul 20, 2021 at 10:18:25AM -0400, Waiman Long wrote:
> v3:
>  - Add two new patches (patches 2 & 3) to fix bugs found during the
>    testing process.
>  - Add a new patch to enable inotify event notification when partition
>    become invalid.
>  - Add a test to test event notification when partition become invalid.

I applied parts of the series. I think there was a bit of miscommunication.
I meant that we should use the invalid state as the only way to indicate
errors as long as the error state is something which can be reached through
hot unplug or other uncontrollable changes, and require users to monitor the
state transitions for confirmation and error handling.

Thanks.

-- 
tejun
