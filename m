Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0962420AF
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 22:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgHKUAf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 16:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgHKUAf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 16:00:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD481C06174A
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 13:00:34 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a79so8194109pfa.8
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 13:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uW8y1yTJsMMsB0OVqI4lO/CwEHl1Ue8UJ+eSRZY4kbI=;
        b=VWQc3cR0otb6Kg318yQfM4v6Xc9xj8PSbHY930a9EaVwe64eTMOSQzKf1KE29lc4QA
         AlhvC+0N2/AA8npgnmZMltIPbLvm7RZS7xTh13RcejMIT0OIkcDP39UKe/YwCnm2EZl1
         iOU9Zg+vWj4qtO5b92VHqG4AnXsGX2HC594GTJzdRuN1a7yf9I80YnJ2hBLGCsKvLL3h
         WtEO6v+EQ557ISKyRsCoP8n/8UQOxk9U3M/kMFXevLqPo0HB4kdbkTQQTZSAEwxqDV0I
         HZ9wOltQLiQ0N65vdacgf16KYoGCHR8LWj4gODMehk4xHN61+NIb26olocuJhfO5JiK6
         zKkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uW8y1yTJsMMsB0OVqI4lO/CwEHl1Ue8UJ+eSRZY4kbI=;
        b=cNiVSPelcrmrZSa+5AossYMLrakmhhoRmfyJaU8BLaAaWtwcI8yx5i6qsUIrIsQhnv
         2qOX+Tlpp4JaaDE5oisbCoUrsEjFOPRtOjA/kfC/95WxlIrEum3Q7HaV2MUo6Kd0SwAA
         z7sB/oO7IG8SKIkeKzIh5+b7MQKA+ZTapjDu3WmLJSGqublihXcGcgZuHF9xVO/MXgd4
         QQRsi0dz9vrDLBPtNinsnScVnude7NV1G1RwuPEVW+oq0vMp3GL85y6kJpzHwRcfFkTW
         F3eGfI2KYYQvz9QZh1h5lTiEoewa6+z43KK2sJI/PQp/30g2W00QK6fKkDnfTmHp5Zn9
         Lvqw==
X-Gm-Message-State: AOAM532npGTy+z/P9m8FmPB5yNz9MtqbUcpHQDs68y7+d5E98aXUbX1j
        y3m9ESTzLUjMNl85pvldctNK16Wrqf/fV7jHd/O/Dw==
X-Google-Smtp-Source: ABdhPJyK0VzskUHAhtE8m903ctamUFBQ6hVLIK5nRtczpYXfz4M3B5XeeUM2UTLTpItDo/+2UTHkY4VA4RmWVxjHvDM=
X-Received: by 2002:a62:7b89:: with SMTP id w131mr7369870pfc.284.1597176033956;
 Tue, 11 Aug 2020 13:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com>
 <20200808011651.2113930-2-brendanhiggins@google.com> <CY4PR13MB117554BB3A5307218EF51EAAFD450@CY4PR13MB1175.namprd13.prod.outlook.com>
In-Reply-To: <CY4PR13MB117554BB3A5307218EF51EAAFD450@CY4PR13MB1175.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 11 Aug 2020 13:00:22 -0700
Message-ID: <CAFd5g47xYF0b+UE1BKSj3vNUig1ST8kX9x-y3FZzf_pzPnvScQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] kunit: tool: allow generating test results in JSON
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 11, 2020 at 12:56 PM Bird, Tim <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Brendan Higgins
> > Sent: Friday, August 7, 2020 7:17 PM
> >
> > From: Heidi Fahim <heidifahim@google.com>
> >
> > Add a --json flag, which when specified when kunit_tool is run,
> > generates JSON formatted test results conforming to the KernelCI API
> > test_group spec[1]. The user can the new flag to specify a filename as
>
> Seems to be missing a word.  "The user can ? the new flag"

Whoops, good catch. I will fix it in the next revision.

> > the value to json in order to store the JSON results under linux/.
