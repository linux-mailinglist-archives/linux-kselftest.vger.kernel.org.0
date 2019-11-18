Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A73100EA0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Nov 2019 23:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfKRWKE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Nov 2019 17:10:04 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:35465 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbfKRWKE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Nov 2019 17:10:04 -0500
Received: by mail-qv1-f65.google.com with SMTP id y18so7272119qve.2;
        Mon, 18 Nov 2019 14:10:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NualcDfguDgEjHtduWi88xZn4omxjI3UeIzUlhWiQrw=;
        b=WTGTR34TPtn1w+i+oEM0gDV2g0w3z8EEPf8iQhSME/jk+EARikr7ezreNlPaNxVp0/
         YmvYdmnI6bKPqkyBf4LkAYu28BD1FtJ+uH5+RXKD9mdJmREwcx6kX6cYFqGTZEoERhkK
         1X15V201FBNuc80B7H7W2DlUBugwHNWc49met0c42T65MgIiILj2lhr+vH8tnyEF4jV/
         oUZwM24rrPEmgBLRjGDPV5/srwVdrKgw1jDDCn9J5G4HgKtl27BWrNh4OHBFg5IGo30b
         zWjJO0E9hIH60jv7NPhRFiy1TAmeu6AdrFNruKRwkhpJd6izWU39Eo9q6z2617MOJUNX
         V6/A==
X-Gm-Message-State: APjAAAUmp5ab2H07MSJ4tfHf3FV9X5LMiCRdWoblwp8ZXLIOG0iGRDKs
        Pu4tmJd9GwfpsjhRUc2DGhQ=
X-Google-Smtp-Source: APXvYqyoEDZZt0Rgs1EpYh0eSDV5u4vQXfyFo35uB7Lo5TheTFOWs5mmMPoo+XcXjJ5Mzj5pp50iPQ==
X-Received: by 2002:ad4:4201:: with SMTP id k1mr21638916qvp.33.1574115002654;
        Mon, 18 Nov 2019 14:10:02 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id r4sm8585486qkd.9.2019.11.18.14.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 14:10:01 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7D15B401EA; Mon, 18 Nov 2019 22:09:58 +0000 (UTC)
Date:   Mon, 18 Nov 2019 22:09:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, keescook@chromium.org,
        yzaikin@google.com, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, catalin.marinas@arm.com,
        joe.lawrence@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        schowdary@nvidia.com, urezki@gmail.com,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net, tytso@mit.edu,
        adilger.kernel@dilger.ca, changbin.du@intel.com,
        linux-ext4@vger.kernel.org, linux-doc@vger.kernel.org,
        sboyd@kernel.org, Knut Omang <knut.omang@oracle.com>
Subject: Re: [PATCH v4 linux-kselftest-test 4/6] kunit: remove timeout
 dependence on sysctl_hung_task_timeout_seconds
Message-ID: <20191118220958.GS11244@42.do-not-panic.com>
References: <1573812972-10529-1-git-send-email-alan.maguire@oracle.com>
 <1573812972-10529-5-git-send-email-alan.maguire@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1573812972-10529-5-git-send-email-alan.maguire@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 15, 2019 at 10:16:10AM +0000, Alan Maguire wrote:
> In discussion of how to handle timeouts, it was noted that if
> sysctl_hung_task_timeout_seconds is exceeded for a kunit test,
> the test task will be killed and an oops generated.  This should
> suffice as a means of debugging such timeout issues for now.
> 
> Hence remove use of sysctl_hung_task_timeout_secs, which has the
> added benefit of avoiding the need to export that symbol from
> the core kernel.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Knut Omang <knut.omang@oracle.com>

This seems like a workaround for sysctl_hung_task_timeout_secs not being
exported. If true, this can be addressed by creating a symbol namespace
(new) and using that namespace on this path.

  Luis
