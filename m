Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB43312596A
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Dec 2019 02:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLSB7a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Dec 2019 20:59:30 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33676 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfLSB73 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Dec 2019 20:59:29 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so5034885otp.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2019 17:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TQOUWeuTEyIUZEEQ2jTpgmNLbvpJOv+XxTa7wYSNX3g=;
        b=OvFqvh8YdAzV55/KDAESLZTnpZ9T/+xm2NNdL3mtyu1mL1Ber7NA3Ncg6I6b7iipv/
         87+tC1A2QDAE4hEaupil/r5OgnOAU0+LIexdh4XDQlJ5PBsHVM39PSrtZl+WeVzBuZny
         6kGu+jbsvpGz8aZPi8Ne1veypupNUpV2ZlQG9SlklJQRVHIPyapP0sLjfUYrK1yPN9g8
         XAWgXdrzAfdnGfaUrLVhKsvUO0epe+i4E2S+uTxfmEQWjHer1Cua9iTKw82qgNrlfn7X
         ito3480sINFyoXjWIBRX75+wF64wksHkV3bEmsaHR9fp9gjzkFdjPPjPQ3k35CqUyLDa
         ABrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TQOUWeuTEyIUZEEQ2jTpgmNLbvpJOv+XxTa7wYSNX3g=;
        b=H56biEzeS3qcLmHOkMYc09UvB8l8TVmOAc00uaZI7SxxLqGih6ULYqJcJcrmsug8O3
         /Zrc9qhNnrTV48YtdVB/7/qCjg8QAAdxMaAkmfx4g5zx0jayVNezw1hEw+FuxRaLZd8B
         kO9GtgUeOfQQOvB3xAMcUEvXebHksfY693R6zrAygeP4GOwts7fcf4WTCP1MyE4DaIbV
         wg1dgGAjAdv5GSN5+OX3mVqBjnYaw3dzEG1NI41XJwRpYDNLNlul++N7ujTHViuht9tR
         HwX1Bi1JW9zUWjwjd3mCDtzLuf0V+OxU08WRaT2oDghcLiP/1auxvbE/9uEdnD6wCJyU
         TVAg==
X-Gm-Message-State: APjAAAXhWiRb1xRMbONZiIcP+dlwOpoueEDIULSeyusotOsHYAy0QIjD
        puxaWPqGup09iYXkFgdu5FWacVSwM0hp3d/FuIyHZA==
X-Google-Smtp-Source: APXvYqz1ha9qc+r4oDyIBgGQt/Isc2y55K20/dwEtbJTlEEWs6r5FLMbK9py0Kzjg45819sYbwm3CtqEmDDBcaTRo3Q=
X-Received: by 2002:a9d:2028:: with SMTP id n37mr6290845ota.127.1576720768716;
 Wed, 18 Dec 2019 17:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20191217231615.164161-1-almasrymina@google.com>
 <20191218171254.79664a964c0c61e6054dff64@linux-foundation.org> <4d11fb25-5036-6c78-5328-10a0c14e8edc@oracle.com>
In-Reply-To: <4d11fb25-5036-6c78-5328-10a0c14e8edc@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 18 Dec 2019 17:59:17 -0800
Message-ID: <CAHS8izMSjyMGTCH-tffiPam_yG9=10v+O617E2cpxWx8SETt3w@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org,
        Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Hillf Danton <hdanton@sina.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Dec 18, 2019 at 5:37 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 12/18/19 5:12 PM, Andrew Morton wrote:
> > On Tue, 17 Dec 2019 15:16:08 -0800 Mina Almasry <almasrymina@google.com> wrote:
> <snip>
> >> This proposal is implemented in this patch series, with tests to verify
> >> functionality and show the usage. We also added cgroup-v2 support to
> >> hugetlb_cgroup so that the new use cases can be extended to v2.
> >
> > This would make
> > http://lkml.kernel.org/r/20191216193831.540953-1-gscrivan@redhat.com
> > obsolete?
>
> I haven't started looking at this series yet.  However, since Mina was
> involved in the discussion of that patch (hugetlb controller for cgroups v2)
> my assumption is that this patch would simply build on that v2 support?
> Seems like the above patch would be a prereq for this series.
>
> Mina, are those assumptions correct and perhaps this is an old/obsolete
> comment?  Does this series apply 'on top' of the above patch?  That patch
> is already in Andrew's tree.

Gah, I just forgot to update this commit message. This patch series is
indeed on top of Giuseppe's v2 support and doesn't conflict or
duplicate that functionality. Sorry for the confusion. I'll fix the
commit message in the next iteration.

> --
> Mike Kravetz
