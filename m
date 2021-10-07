Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06DF2425727
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Oct 2021 17:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240912AbhJGP4h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 7 Oct 2021 11:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbhJGP4h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 7 Oct 2021 11:56:37 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733AFC061570;
        Thu,  7 Oct 2021 08:54:43 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id w11so3636339ilv.6;
        Thu, 07 Oct 2021 08:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEeeOHW2XScEPt9l9T7cyjA12nlEqvYFpEPTjeOlhtk=;
        b=GozB4eJgGzxuSljp5CgF97+YvAQZiobXsfKatDDQ3SRdjV2w8zl+tdKbRMUkZ11WcY
         BmsMIF92hW1T1Jdh5lxRyNQ66QsBegrZZ+oA2TEwHuVAddzl1effAhfw7pZD6aiBsE7x
         +vZf8T3375mHEuNkUinYCN5zcXtkNNTr81FAmSWvrZ0eGcy7NuSWVsgZVXjoOM6/OHMo
         ZkHWT4MKtp4InKxaDfwpGg8drLeh4nWQ05eDCw/Xb3d33+ARxwS4ZjH9btiE6vbM1u4R
         KIFemT4+ChWkJl+rH2yst3brWqM8DyXlwFZhQBiXMaSZnRU7AAACPOd02GJNDpnuaEUC
         8w+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEeeOHW2XScEPt9l9T7cyjA12nlEqvYFpEPTjeOlhtk=;
        b=6Wg4W+kldb2yjvWcKvV5yX/J9ooxvqQxb+UKCd+xy8oQMOqK+R6PczdYou+BF3YNuB
         7r9hV3MxycFYBL2xHQ/tz2cbRZdjBrokvAIm7TuXD3H71Rppid/asIFdGAjCRVyRA4KR
         Iu8lItPY5qMJ/rZcf8EP2r+4YMZEKFnijVi0wdz6Hh9q9M+C3Fe1NLf3iHC5jaJomwCa
         sHdGBQB3dRgE23JTe6Kh0EsdTHNZRku6+SMZOcQKIxE6Vz6kKOrxeaSlSNBVVqoh/Vks
         d/vTB9zukai8LQtdwZKy+sWL4mAVcxg3vGDFiaDxt7biIzrG5K4oGvdnjSkNWCf56FGX
         t9ig==
X-Gm-Message-State: AOAM532kFbUOrwApz91X8kgXmvwBIxZFaiUxzuM9Zgcv9LjJz/W1/hrm
        qLceJCC68qf9eXs9fmRJCFEWJfTnHP0mTdUkOJg=
X-Google-Smtp-Source: ABdhPJzmi9FW2Opfs1nIzYmaM2A75n805ZIic6DitSDDSrvjWB4ocsStnK68m9Da+iZyOmOC4GLILSc2WVwn06BgL78=
X-Received: by 2002:a05:6e02:1d86:: with SMTP id h6mr3917519ila.5.1633622082893;
 Thu, 07 Oct 2021 08:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211007154407.29746-1-andriy.shevchenko@linux.intel.com> <20211007154407.29746-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20211007154407.29746-3-andriy.shevchenko@linux.intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 7 Oct 2021 17:54:32 +0200
Message-ID: <CANiq72=pCQgwHe5u2nS_RkGBnRLdcw2v=vk-8eNDeAP9ygO0SQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] kernel.h: Split out container_of() and
 typeof_member() macros
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 7, 2021 at 5:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> +#define typeof_member(T, m)    typeof(((T*)0)->m)

Is the patch missing the removal from the other place?

Cheers,
Miguel
