Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145092E1FA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Dec 2020 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725907AbgLWRAX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Dec 2020 12:00:23 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:34504 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgLWRAX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Dec 2020 12:00:23 -0500
Received: by mail-pl1-f170.google.com with SMTP id t6so9426640plq.1;
        Wed, 23 Dec 2020 09:00:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C5J0im/g/lziWkOXhLJMkLHB39Y3IwOJRzVpXSFIMwo=;
        b=b7FVHvlxZxgfeH70dfJLxtdeSo+wXThcBKdgGERIWTOI5L5I1oCrHxVRjOc/QM1QE/
         XAZAYx/wf7IF2iqzGrel57kS4MBRpvgE3bjjhJYqsjnoAruEN53BxmkKkrPF0g2qdGkO
         ixsyUqwkR6jEICWv3js50/+qXyuUzI6gC0A8/uDEKn8GtxscNMx5Qzgo+A0TMH6dqZCS
         xNK5h/7r2b+Gp3XbHeUFV61UPPOj75yu+JJyGhXQutlba/I4oA5B884Ml5mEJ2d/0+GV
         lIyddkVteXIkfbDepHQANFZw4pEZO0sMA5ChirvtOp+zWZO6TIzVzmtM6A7PsmFGUFR8
         vt8g==
X-Gm-Message-State: AOAM531qEV/o/DkBQufxCKDOg4WbBhtGy0QWM3+2HtCqwO8AVgje3Xpe
        U3z/lcw+7lrt1sI2v2O50g69mS/yoxM=
X-Google-Smtp-Source: ABdhPJzqv31c8q2ac9TtdhmNSe0N38boCxuCdDiKIhDRPStVefyp5/WAIeJm9xrsMsbN4NqKKvm8qw==
X-Received: by 2002:a17:902:523:b029:dc:1aa4:28e7 with SMTP id 32-20020a1709020523b02900dc1aa428e7mr26256507plf.4.1608742781850;
        Wed, 23 Dec 2020 08:59:41 -0800 (PST)
Received: from [192.168.3.217] (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm24081106pgh.15.2020.12.23.08.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 08:59:40 -0800 (PST)
Subject: Re: [PATCH v1 0/5] dm: dm-user: New target that proxies BIOs to
 userspace
To:     Christoph Hellwig <hch@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     snitzer@redhat.com, josef@toxicpanda.com, corbet@lwn.net,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        song@kernel.org, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
References: <20201222143616.GB12885@redhat.com>
 <mhng-26d96d8e-77aa-415b-a8ee-518a0e91b6ef@palmerdabbelt-glaptop>
 <20201223074850.GA15369@infradead.org>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <8f09b196-0977-3b81-2bfe-4a97b1e0e3aa@acm.org>
Date:   Wed, 23 Dec 2020 08:59:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201223074850.GA15369@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/22/20 11:48 PM, Christoph Hellwig wrote:
> FYI, a few years ago I spent some time helping a customer to prepare
> their block device in userspace using fuse code for upstreaming, but
> at some point they abandoned the project.  But if for some reason we
> don't want to use nbd I think a driver using the fuse infrastructure
> would be the next logical choice.

Hi Christoph,

Thanks for having shared this information. Since I'm not familiar with the
FUSE code: does this mean translating block device accesses into FUSE_READ
and FUSE_WRITE messages? Does the FUSE kernel code only support exchanging
such messages between kernel and user space via the read() and write()
system calls? I'm asking this since there is already an interface in the
Linux kernel for implementing block devices in user space that uses another
approach, namely a ring buffer for messages and data that is shared between
kernel and user space (documented in Documentation/target/tcmu-design.rst).
Is one system call per read and per write operation fast enough for all
block-device-in-user-space implementations?

Thanks,

Bart.
