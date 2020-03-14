Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C5AF185315
	for <lists+linux-kselftest@lfdr.de>; Sat, 14 Mar 2020 01:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCNAAw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Mar 2020 20:00:52 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33738 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbgCNAAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Mar 2020 20:00:52 -0400
Received: by mail-pf1-f196.google.com with SMTP id n7so6267109pfn.0
        for <linux-kselftest@vger.kernel.org>; Fri, 13 Mar 2020 17:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iO0VXAVsDr+jrGc2J5VMFCqZrTIBZSEm85Bpnc3jnQw=;
        b=cYSyUkpLqfBDrimiPCGrZ79sbUkn6OZZNkn0mT+p6AESDR+MxB3Dxbi3LjI/XHBEW0
         jixSKhJWgdpU6yy4PIgSDKDVr05W3yE0MMHMkyEYQ0QvSD+dDfcZzHQA1CRsP3MY5DYR
         uTxo4dsaxj6JsYpZ069X8V6Ve+7rjWrhxGdJpCrjCdaJTTQjMVRHcizfAJIbCMaholIZ
         9RsZVhRsmEz8eH9JOhwM4U92rpbpmZt2XwW9KsSc/gjBI75CfD7ZgfMM2BgrfIaEEtqb
         AxLAsuf8+pkN1Yz8uwR8NqYWJamWHPoEMMi/4id5n8wmtaZT8XO7rx69q+NvSA9T2BvE
         DANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iO0VXAVsDr+jrGc2J5VMFCqZrTIBZSEm85Bpnc3jnQw=;
        b=OYI7tKmaHo4JxZJv0b5S6nosFfrdl9H8sHry8wKyy+J+Rg+Ei5/A9eZ3RzX69O3qfW
         B7rgFCURGv00IftO8WJR5cpyRikkucwHO2oLXaP/g92cGTPpGfoGL8Q+K/EBtNf96wO1
         laXmy68P5+6iOaWTBwzlAbuUee69RcCvUOVIALuNrwdvq9NRYj6A9Ifs6BoqMFQpACQ+
         6zDqDw227s8x2tCm/xCNU6CDLOQWrkuap3ZU7gENiUsp+SahvmynvAVMk5RG2mljzT2o
         JnXRFfJS/b8I3Bokw98qqUBDKbE8ESN7C2Q9LY5ZdDvSHNv1Z96kOC8bKdEzPE2nrFn9
         245Q==
X-Gm-Message-State: ANhLgQ0aau9zPppnchiPrM76on8YgLIkr8dp3RrhzSR+RS+JIXZH2164
        WLBbp6nTCqBz4WBqv1GCCtXcT1OOfVHGbsw4+bWIGCDOWUw=
X-Google-Smtp-Source: ADFU+vtgMeZwS04JEhC1+g+bpbuAE/Pax//u8KT5l5j2FKkS6CojvWXcPfv6kJ7ELgKrpBqLBkgAlIbqYOSj0IlhGSw=
X-Received: by 2002:a63:650:: with SMTP id 77mr15213263pgg.201.1584144051096;
 Fri, 13 Mar 2020 17:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <1584110682-3837-1-git-send-email-alan.maguire@oracle.com> <1584110682-3837-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1584110682-3837-4-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 13 Mar 2020 17:00:40 -0700
Message-ID: <CAFd5g44HG2U8oFYvvjcVPYOvom07+JeTMpGqLtyKGnHQh5+sEA@mail.gmail.com>
Subject: Re: [PATCH v7 kunit-next 3/4] kunit: subtests should be indented 4
 spaces according to TAP
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 13, 2020 at 7:45 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Introduce KUNIT_INDENT macro which corresponds to 4-space indentation,
> and use it to modify indentation from tab to 4 spaces.
>
> Suggested-by: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> Reviewed-by: Frank Rowand <frank.rowand@sony.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks!
