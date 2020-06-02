Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378281EC2D1
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jun 2020 21:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgFBTeD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jun 2020 15:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgFBTeC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jun 2020 15:34:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EFBC08C5C1
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Jun 2020 12:34:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d10so5625297pgn.4
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jun 2020 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhbHp95kWOKsMTn2kJlI+6kFGDRXkED2LqzxYSlher4=;
        b=MhJcTwo6HwYbNgEc+ExSmsO0IlkIo33Me4OFsIko7H4p/davHsjvQxCaIzy2uipC/L
         g21jxZG9y+j6bT1t4kLB724vx+92V/V0ZqhEWjg8h9HWRFFA+0/dWiwdM93iT0pwFtu+
         GjlDPX/tc5iJEM9O5CzsheMcC9RsVnTfvm8ogdPF/7g6zox2rGUPot8TH+w4QOe9JJ1h
         IP8heVwfINOhnM4vy66T46rMPul0Q9aSoH1f6FbOtR6XtW66ucBx6Pc5HM2QKUBVvyNi
         yn4RCI3gBeOodqATLm/YXEf/yDpQ357CmWMldGUq5+h5uNI3hmHY1lYgYfXPaxE2UHNV
         bdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhbHp95kWOKsMTn2kJlI+6kFGDRXkED2LqzxYSlher4=;
        b=NiIKZfT6eNxSqI5uT6TPYcLeCSwTJ//4NgVMaaEnuZP7Gs/QYiUcYVSzbDjpIbOfqN
         J/kcC7BN99THg8DdwdG3oWvEfwMfKdCX9gsO+5Ki3itbO+USGmn66qWtRbvH5o0r63Im
         rRkgsqNC717E0WLiBQK8DskIDfc15RwBqsWcU9uQ0prqfAJAT0jGqmo2Do4dTma4DCUj
         OMn/E/aMt9jCmVlutbfb7gAzc3zdTQ7ToLglRX+h/uYuHG+pURWrqYVwahiXS07iSwzZ
         wM/7r9nUIkMBL6OfE0ZFJAGV5yipaDFfFDuf4aL0rfkux2F2lOpKL5/D4prt4wfTlboq
         wKmQ==
X-Gm-Message-State: AOAM532HcXWOb1HxyN4RitUE9alXukKNSx+2Kx1uzbMaGorcwpv6Pgqk
        +JDo9fqBIQqF0ulAovpu5AzA9F6Eg/rZjMGYRBB+kg==
X-Google-Smtp-Source: ABdhPJzQFBBEXGlVKjw7y8H/AbAaadIBe0OvYKSn2tDk4MZhCitP4+Od3+GxdYCieJxU/fGoA9D8ydtazPOWH9RGC88=
X-Received: by 2002:a17:90a:df82:: with SMTP id p2mr766872pjv.217.1591126441371;
 Tue, 02 Jun 2020 12:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200602054216.93122-1-davidgow@google.com>
In-Reply-To: <20200602054216.93122-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 2 Jun 2020 12:33:49 -0700
Message-ID: <CAFd5g46cJPD5X=88dwwd4Y9v1o18MsJiX47qjkTVAN4DbEPrCA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Add some troubleshooting tips to
 the FAQ
To:     David Gow <davidgow@google.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 1, 2020 at 10:42 PM David Gow <davidgow@google.com> wrote:
>
> Add an FAQ entry to the KUnit documentation with some tips for
> troubleshooting KUnit and kunit_tool.
>
> These suggestions largely came from an email thread:
> https://lore.kernel.org/linux-kselftest/41db8bbd-3ba0-8bde-7352-083bf4b947ff@intel.com/T/#m23213d4e156db6d59b0b460a9014950f5ff6eb03
>
> Signed-off-by: David Gow <davidgow@google.com>

Looks good to me + Alan's suggestion.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
