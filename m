Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB8ED0220
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2019 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbfJHUba (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Oct 2019 16:31:30 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:33815 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbfJHUba (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Oct 2019 16:31:30 -0400
Received: by mail-io1-f66.google.com with SMTP id q1so39588500ion.1
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2019 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ufHv6vT4xEyL5yxrJBmvyPi87IMU1bsHtqAtrjZ/rms=;
        b=XYvRLMJ1HNJTpTed6TzmxZm2RELThI1bdF5PdFyGS1t2SfYcGiKWZa5yeqpUMfl0cP
         mq1gDiSs48Z4AjSOmQRw0MdUyg0elu5vXESTKZBSIBQDrdQ+w0titO3Eh3jUjCPnHgLM
         aJfQkPA41SP2P9X/jslyooTwwVkxt1FgGYQcY7SyNB/Nh24pcIsE8UYOCOIhBVGjwIQ4
         kgKMpojqTHkwK8Z2h3s1+4cGDI65ItdmvnstWDmrNJh4sOJN+5RL8A47WtjP1A2CDoi0
         OrxXldqn9JvuSJ5p+R2Dc+8V7vnZG7nw45BcLxCjh2QrMzbrFTqNZL4LD+ghrDCXnMhw
         l9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ufHv6vT4xEyL5yxrJBmvyPi87IMU1bsHtqAtrjZ/rms=;
        b=ulgigOchQQO6Q7rrkzMovBCmuLx2aYMPpkriufPYg9SqkcIcXWLW4BZYNd0+K1sIeT
         yiDQaDDyhDCjDS4/5PbIzQr/KKsRrRLHXLHTtv6w6ZsL1QA5Te4PJADeStZlQmOzGTzj
         iB7Htrz2zZgD8Vkpbt1l0kHeADVecjSrbKN0uyp2sJD35P6WOpE62mBxlufNgfskzzUX
         uVF/TkpFRe1VdbP7MxffC0Qdccyf7dnZGitg69GbMVt6ymrcEQJor7btgbAbU+qYmsqE
         wmFglIeYJNBcp1odeKYy0lN6dUL/VF9EjQC1Gh2zhsSLSK6WyK5ixgmon3DUBkQ+a8P8
         bdFQ==
X-Gm-Message-State: APjAAAXjRIRCmUkjkYjU9ukZrm2SyeOHs+HQP4dXNzACYKRNU6i9WMhC
        GkrCFj8U0Q6ns7aKEN0gk8U44g==
X-Google-Smtp-Source: APXvYqz0lu1liH7ZLwLcViVO+xgc0li+wka+uuHPe6JbWky5hQ7PZX/syGJCKryloCt7sNCezASDvw==
X-Received: by 2002:a02:ab85:: with SMTP id t5mr33958524jan.23.1570566689487;
        Tue, 08 Oct 2019 13:31:29 -0700 (PDT)
Received: from localhost (c-75-72-120-115.hsd1.mn.comcast.net. [75.72.120.115])
        by smtp.gmail.com with ESMTPSA id q66sm72970ili.69.2019.10.08.13.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 13:31:28 -0700 (PDT)
Date:   Tue, 8 Oct 2019 15:31:27 -0500
From:   Dan Rue <dan.rue@linaro.org>
To:     shuah <shuah@kernel.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        lkft-triage@lists.linaro.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: next-20191002 kselftest results
Message-ID: <20191008203127.6ifehxzrz5ruxz6m@xps.therub.org>
References: <1018171707.4561.1570021237760.JavaMail.javamailuser@localhost>
 <09618fd2-eb41-5a82-3fb4-4f4ca18bd075@kernel.org>
 <CAEUSe7_+RQ9UPjJW1TzFwfCpcFuOv9ha7k_Lf46RJTg-=gVf_Q@mail.gmail.com>
 <CADYN=9LeWLqQ4cYAQ=Fk-xD_O4UxPN+GSwgqyB3UH3j=xH0KLA@mail.gmail.com>
 <434b3683-77c0-0a11-80e5-3329b5d20069@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <434b3683-77c0-0a11-80e5-3329b5d20069@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 03, 2019 at 02:03:28PM -0600, shuah wrote:
> On 10/2/19 8:47 PM, Anders Roxell wrote:
> > On Thu, 3 Oct 2019 at 04:15, Daniel Díaz <daniel.diaz@linaro.org> wrote:
> > > 
> > > Hello!
> > > 
> > > On Wed, 2 Oct 2019 at 20:52, shuah <shuah@kernel.org> wrote:
> > > > 
> > > > On 10/2/19 7:00 AM, ci_notify@linaro.org wrote:
> > > > > Summary
> > > > > ------------------------------------------------------------------------
> > > > > kernel: 5.4.0-rc1
> > > > > git repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> > > > > git branch: master
> > > > > git commit: a32db7e1172439240202b843642465618498170d
> > > > > git describe: next-20191002
> > > > > Test details: https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002
> > > > > 
> > > > > Regressions (compared to build next-20191001)
> > > > 
> > > > This report is nice for quick glance of test pass/fail/skip dashboard.
> > > > I am finding very difficult to figure out why the test failed.
> > > > 
> > > > Can you please save the test run logs and stash them for access?
> > > 
> > > Logs are saved. You can click on the test details:
> > >    https://qa-reports.linaro.org/lkft/linux-next-oe/build/next-20191002
> > > then opening "kselftests" in Test Results, choosing an environment
> > > (say "x86_64"), and then (here's the tricky one) "job_url":
> > >    https://lkft.validation.linaro.org/scheduler/job/948404
> > 
> 
> Too many mouse click chasing these logs. Can you make this link on the
> dashboard.

Hi Shuah -

I agree, and I'm sorry but I am not sure how to make it better in the
near term - qa-reports is a generic interface and so it would be
difficult to show so many links on the summary screen.

What I'd like to do, but it won't help anytime soon, is generate better
reports and have the links in the report. Unfortunately it would be
pretty difficult to do that in a text based email report and using our
current tools. We are actively evaluating better reporting tools, but I
don't expect to have anything running until early next year at the
earliest.

Thank you for the feedback. If you have any other questions I'm happy to
see what we can do.

Dan

> 
> thanks,
> -- Shuah

-- 
Linaro - Kernel Validation
