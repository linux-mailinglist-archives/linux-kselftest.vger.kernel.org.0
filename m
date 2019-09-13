Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA52B2700
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Sep 2019 23:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbfIMVCz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Sep 2019 17:02:55 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:40773 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730847AbfIMVCy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Sep 2019 17:02:54 -0400
Received: by mail-pg1-f177.google.com with SMTP id w10so15881644pgj.7
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Sep 2019 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=veSHReB4gbVlNiWA7ZM0iHyqgiNq/GWOvaI7sxDbWYs=;
        b=ujocWjo8ybCQ9MKIB9y9FbiP1Lt9ILV9SWMDQqqKZWcOijUvA/Mq+4gU090kcVDUXl
         Vu13WNkp5aevZKGrLUt1K7k5eA4psk9rxIYvacmdUYkTKzSpAoU/E86jf/wU8geyxvM2
         pSg/rcNYQ5KakBjc4y4M0vLEpPJvJuSlVnqYGK8FoHJjATrcGsiBEWTJjf0sgsHnguXY
         nrklVwvDjltvIPWv7/9D3vTBiMRbT4ZnFbAV86pMXmHNUjd0GHBUdkL1NHrGdUHFVZdI
         mHQlr45VIj1usEvTdnIluAcg9jMvF2GSGQtYpTMn9o+ihDox2iXGiQ3bqyMMzK6sEBHO
         N1lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=veSHReB4gbVlNiWA7ZM0iHyqgiNq/GWOvaI7sxDbWYs=;
        b=HHUwIFGCZZjrbbCfHv525jgc1TPAu47uDlZwS3vaMXEPTSDPRJrhlniWYTNoRHph/S
         FWN4e8KZPnjBKKVDCkZ6obaDY5Xdem9CViQS2noXA3JqqjizdH4LWMxlWFRyeEArKlzh
         6RbO3bN/6S4A7tdTBI6pYm5mzOHGVtmd/Tmoc6KDSubXxJYrjvsW89BcY3utX1uZdmSg
         ldMBVj+0u3HSn3i0HFdwJdOe1Um/qFxoe9GdbsIWsBwji+sOy5zuJ7KPUpYLcnF9Tn8S
         mzxvf31JnlXjN5iGBr8TPJLlm1jbkevC6dXblvDYxE4vrkfww35DGL693dfzXAG8nZBR
         TbEQ==
X-Gm-Message-State: APjAAAUBnT90RmZqi/NPvYhe8TLVH8c98JFR/y0y9/nV63Jt9yAsaJ3Z
        G6xbYBuvHeGQ9UDz8J4lfGMQTg==
X-Google-Smtp-Source: APXvYqwR4A6jdTmnDxiRo8XmggIyWRvySI09QLM/SIk0je4FYqhlUaLt6PiIIqO0PVBqDcsGSOY56Q==
X-Received: by 2002:a17:90a:bc08:: with SMTP id w8mr7414252pjr.80.1568408572944;
        Fri, 13 Sep 2019 14:02:52 -0700 (PDT)
Received: from google.com ([2620:15c:2cb:1:e90c:8e54:c2b4:29e7])
        by smtp.gmail.com with ESMTPSA id p189sm23267711pga.2.2019.09.13.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2019 14:02:52 -0700 (PDT)
Date:   Fri, 13 Sep 2019 14:02:47 -0700
From:   Brendan Higgins <brendanhiggins@google.com>
To:     Knut Omang <knut.omang@oracle.com>, Shuah Khan <shuah@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org
Subject: Plan for hybrid testing
Message-ID: <20190913210247.GA86838@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hey Knut and Shuah,

Following up on our offline discussion on Wednesday night:

We decided that it would make sense for Knut to try to implement Hybrid
Testing (testing that crosses the kernel userspace boundary) that he
introduced here[1] on top of the existing KUnit infrastructure.

We discussed several possible things in the kernel that Knut could test
with the new Hybrid Testing feature as an initial example. Those were
(in reverse order of expected difficulty):

1. RDS (Reliable Datagram Sockets) - We decided that, although this was
   one of the more complicated subsystems to work with, it was probably
   the best candidate for Knut to start with because it was in desperate
   need of better testing, much of the testing would require crossing
   the kernel userspace boundary to be effective, and Knut has access to
   RDS (since he works at Oracle).

2. KMOD - Probably much simpler than RDS, and the maintainer, Luis
   Chamberlain (CC'ed) would like to see better testing here, but
   probably still not as good as RDS because it is in less dire need of
   testing, collaboration on this would be more difficult, and Luis is
   currently on an extended vacation. Luis and I had already been
   discussing testing KMOD here[2].

3. IP over USB - Least desirable option, but still possible. More
   complicated than KMOD, and not as easy to collaborate on as RDS.

I don't really think we discussed how this would work. I remember that I
mentioned that it would be easier if I sent out a patch that
centralizes where KUnit tests are dispatched from in the kernel; I will
try to get an RFC for that out, probably sometime next week. That should
provide a pretty straightforward place for Knut to move his work on top
of.

The next question is what the userspace component of this should look
like. To me it seems like we should probably have the kselftest test
runner manage when the test gets run, and collecting and reporting the
result of the test, but I think Knut has thought more about this than I,
and Shuah is the kselftest maintainer, so I am guessing this will
probably mostly be a discussion between the two of you.

So I think we have a couple of TODOs between us:

Brendan:
 - Need to send out patch that provides a single place where all tests
   are dispatched from.

Knut:
 - Start splitting out the hybrid test stuff from the rest of the RFC
   you sent previously.

Knut and Shuah:
 - Start figuring out what the userspace component of this will look
   like.

Cheers!

[1] https://lore.kernel.org/linux-kselftest/524b4e062500c6a240d4d7c0e1d0a2996800cc0a.1565676440.git-series.knut.omang@oracle.com/
[2] https://groups.google.com/forum/#!topic/kunit-dev/CdIytJtii00
