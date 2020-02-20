Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7E16534A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2020 01:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgBTADo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Feb 2020 19:03:44 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:44917 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgBTADn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Feb 2020 19:03:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id d62so25679999oia.11
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Feb 2020 16:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YHeIdmxOoP0hF/CsX1z22j/VcXTF+m2n9SPCMuF9eo0=;
        b=Q0qIGLPNuwluFhVMJjoUI0Nx6z7pyTSN7DOfAsbF6qO5OaYP+p/1yvW2zX1CgLr2HR
         K0OgeL1DtnewH8OGFkdUlXrehmNjgUiIXmJO2aiXfD6jEWvT99CQpYWm9279KjIQ4rbC
         Ya0A4bWv87EWS8lzBJ0Q7f88+9UwlAhD77pFZTnGu/UdG670VRiS2sIULtT46781IhuI
         YbiRP83N+GEklKllMDq1Vek5xCN/2MVOULroAXTqfgQk29icTjdS+Vg05p3ZdJgbNefK
         Z73ntL+t70lQkgEHoyThAMI7NElrteSsI7AX1PvyU62Z0Q5z5sqdYuGQTfs1sARnFNO2
         vIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YHeIdmxOoP0hF/CsX1z22j/VcXTF+m2n9SPCMuF9eo0=;
        b=jIFmfFrQM1Be9geDmmEUoblFefnAzjrsGZTNH+BgyFpR4ADAbx7WcoAeOsA4q0xeL6
         jJDV/KWjIp3oc4KxdiwruRkWhVv2690vUSK6wObddOhQ/e4Gqp5PyQA9LfVwUxb2EUfm
         ERvYPUXB5It6Z6bUEgWTkhO5eQF8ga1sE2Ydh6t9IjGrQovISe3RyKWnRE0T3VYR2I/n
         9L5JElYzleNpVKI1J8gJiN4zBf3lt+OV1qJsIjxTalLypzc8EPFSa0GbuxNB+RV/yezX
         V4yKdSp2tjLrblT42QJooehismjw2DbYsjKhhUsI728ZamdlDd0bUrUBUDOn1yEqhNjT
         eIFA==
X-Gm-Message-State: APjAAAXR3qL6tRb8WCMYf0qcQnjmVzM15aD7MzhVFAVTURqcoPD6yuMk
        9vU5SV/6GXVsn7YCeV/6zlhTA/CpkcB4chSfvEKnJg==
X-Google-Smtp-Source: APXvYqy4o4y6JMY/d+GfmgPPn6aadmNotKQEgu1SrOfear8zoHkmyiLy8ANr0b88zOSHe3kLSAM67virA8+YlW+Y1os=
X-Received: by 2002:a54:4086:: with SMTP id i6mr173786oii.65.1582157020886;
 Wed, 19 Feb 2020 16:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com> <20200211213128.73302-9-almasrymina@google.com>
In-Reply-To: <20200211213128.73302-9-almasrymina@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Wed, 19 Feb 2020 16:03:29 -0800
Message-ID: <CAHS8izPfaq=rfUrQGDyOwbgZhw96Qbos9xAdJzs35KyLB_JZ-A@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] hugetlb_cgroup: Add hugetlb_cgroup reservation docs
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Feb 11, 2020 at 1:32 PM Mina Almasry <almasrymina@google.com> wrote:
>
> Add docs for how to use hugetlb_cgroup reservations, and their behavior.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>

Hi folks,

By my count this patch and the tests are the only patches in the
series awaiting review. Can you folks give it a look?

Thanks in advance!
