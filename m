Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5B3B3453
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Jun 2021 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhFXRLp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Jun 2021 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFXRLl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Jun 2021 13:11:41 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF97C061767
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 10:09:21 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v5so7093162ilo.5
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=SbiCS9fe0tUzMN9Mlo4ZdzG6CED/4FAcSxg0wo/ziQYDUVCsP2haiMKLP0Zm8Zz/48
         5KK4SzZ10wtJBf6XxSApB80sqvc7uFNto3JlTM6wlJfDq3br9/d05YJV+26Z9funZ0QJ
         zC673NeJb7DCIp9tsq/7VqKjJZZ4pA1wVOLRyrCTaUf5sEq2BYY3kJAyTAoR3PFpihkt
         cWIDGo2nPXEt/5haQaoQd7wjhl8AxyNXoCPbkUDAcwsRA/AaaiI4n9MU7dS9MCzxREc7
         2fYhmytGgZIOxEvf5OTm2vYjHhtdDfLEUwVEUY8H9FNEp+YNtYOqcjHL4N+tuNLHcFiU
         J3aA==
X-Gm-Message-State: AOAM531PsXwn4Cm/wNyNzJyLrcdUGJ9DHTAHFXt4XYGxgq2TlBHDnO+r
        xmKIUhPxvqTEj/VK8T6hSMQaryscnfwKPrLcVRg=
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
