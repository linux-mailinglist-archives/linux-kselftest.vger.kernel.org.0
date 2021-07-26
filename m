Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D763D6A0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jul 2021 01:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbhGZWds (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jul 2021 18:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZWds (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jul 2021 18:33:48 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7154EC061757;
        Mon, 26 Jul 2021 16:14:15 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c16so7966732plh.7;
        Mon, 26 Jul 2021 16:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XlqO27qrjwfCjHyqQRAvgHsZUjwQ3+Wx+UdEzbB2q48=;
        b=fRN69KFrOsFKhC2wPvWFRZ/lnteV9fg9+31gTf41zkgI2F9buQPBEFwJzW0MB6O4Oe
         wbOo2wBtauY2JNE2Es8k6waNss5Vw0BX8xPVea3oDO4fJ9jKOr6sS2LHoo1y8K4sbxyZ
         1trKsdUAnNYAkpcNBgYH9+nRiZCRSZ/UvkUVXsc83HoWX7WotrEGFSs1PESiqR750pF8
         tCF5b2p30Bz6nwkKpK9sadVCdlO78fny0DclfIdUzp84h3/7cRl5qvq+NOab7ih1QhKb
         GJghNMn5cAfg603IjJOMJ9TNzkWgepc3XsApEKc0WIIn8wkYKYyAefE2xCMayBhi9Idb
         kH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XlqO27qrjwfCjHyqQRAvgHsZUjwQ3+Wx+UdEzbB2q48=;
        b=YlAHErBuy5GdofhqVFQErvkQYiQGT1FXWfsTlfmEy9qosh6hlcPCb7zAEGifwekg8/
         HEpc66K2yXedLHfQcGOY2AJgCqePsZUIYruwiFh+VhUjfN1T0pAfK6IxWokwTkWyf6Jv
         3FpJra552HiArMZ43Y0R0ZtjPqBnEdhtnV1XZV+nO6m0Ug2FIjMiLkf7owBcllZrYjeC
         yJzHZ+mZ8eO7oIcgQ4Grmy6tdwi7Oj/IFZOYMAgUl0DG8mpR3gsnRjAhOY4lFpT+VY3W
         lzr/rzHjJMTZWMSvvoG/G/RqQ1Brdog5ojmo78HkjyCJPsZtWWKSttAZsAjxi7nZdCGg
         j/YQ==
X-Gm-Message-State: AOAM531bxxhwFkQblo0J29tMu2Xd9vcExo/30xCS9lMXJ1naSf24aHRg
        yfqRhyJar+R1rz18POTgCBo=
X-Google-Smtp-Source: ABdhPJxLjAnUPpcRcZsgE0dosF8P9RI3fz//g3BMrTbbGbNzUGV+1cFfL7iFyp0EdtRsJ8A66eTsPQ==
X-Received: by 2002:a05:6a00:1c73:b029:328:6a4f:f22b with SMTP id s51-20020a056a001c73b02903286a4ff22bmr19949350pfw.17.1627341254748;
        Mon, 26 Jul 2021 16:14:14 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id x189sm1296860pfx.99.2021.07.26.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:14:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Jul 2021 13:14:12 -1000
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
Subject: Re: [PATCH v3 4/9] cgroup/cpuset: Enable event notification when
 partition become invalid
Message-ID: <YP9BxKXfhaoTE+LO@slm.duckdns.org>
References: <20210720141834.10624-1-longman@redhat.com>
 <20210720141834.10624-5-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720141834.10624-5-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 20, 2021 at 10:18:29AM -0400, Waiman Long wrote:
> +static inline void notify_partition_change(struct cpuset *cs,
> +					   int old_prs, int new_prs)
> +{
> +	if ((old_prs == new_prs) ||
> +	   ((old_prs != PRS_ERROR) && (new_prs != PRS_ERROR)))
> +		return;
> +	cgroup_file_notify(&cs->partition_file);

I'd generate an event on any state changes. The user have to read the file
to find out what happened anyway.

Thanks.

-- 
tejun
