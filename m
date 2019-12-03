Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE991103BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 18:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfLCRl7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 12:41:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37403 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfLCRl7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 12:41:59 -0500
Received: by mail-pf1-f196.google.com with SMTP id s18so2204249pfm.4
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Dec 2019 09:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPNclA55GeMuTPy00O4xA3XNidBB0rleD9eOny3IQXU=;
        b=CA8U+ILSVCqpsw6oVcTIiykcDXOPtAQZ3dRCBFCZF1Nnq9ZRybkNiuadJE3k6L38nk
         1nM6dfAtI1nmuq17a2w3pQeYTJcbN+0E7hZQXNu1BmYtv22ZIo+H6t8xILsvT5l3PK3F
         jKAh96PdF5kuA3LEMjN+Mi1PK/05bdRSWUicAd9PMzhTT1G7ELE6IpqgsinlpfSopyS/
         lODY3D32qAbzArZ+QI45bVCSRWDjJAaFswGXvQ/spe0FY5bCVUlTftGsJzDCsvmGUaqy
         wBCVGR89Awy9K5FZunIUztSkOLIa0VchzzRL68mjE+rANibb5Yi+gTiKo9Ce0FEKX68U
         pmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPNclA55GeMuTPy00O4xA3XNidBB0rleD9eOny3IQXU=;
        b=jjV5tRuxR+TDe2zA+v/UK/99wfc3cr6+hYjRFPHvQPebjFbevjSvA61mFu4ThyfVsS
         oeWEPn5WAit4oISir4QH17k3ue8/1pZwS6mQ4ikzN8J8LQ/OMS6GmBN8z+RU8GOrk8Ff
         7X+Vs22Cp5QRwkcTI4Ndu8OdPXiCPMBvRkoYqxvUgshpg2LOpDCX4yL8Ae0fnDXvaqpX
         dgiWmQpnlLBakyquFnpNKCI2BARIaQI28Dvc8Unn3X7soTLVtUIv3EdmQVkjGJhIhi91
         2YZzlUUCL++I9D62VZYkW0O1jVMi6GICqo+DjujO38FboBuMDy1KF6TOdT2m0Pij/NQf
         uWYw==
X-Gm-Message-State: APjAAAVHkJd3FmU/RY4ro6S50Wakt/fQixKY3ISJWoI8HCK0YXASio30
        FXIkS/TVtrrpmZx4VEzrqYQPHUm9/g4niKzYGMqrvw==
X-Google-Smtp-Source: APXvYqyLfrzqw76FsSf7xNdSx42vZjlHk3EqzEY2B6hdnMDa1YuE2bPl3G/so4GSGjfHNmL5z7UDa/RdVqlVulsRkzU=
X-Received: by 2002:a62:174b:: with SMTP id 72mr6112264pfx.185.1575394918652;
 Tue, 03 Dec 2019 09:41:58 -0800 (PST)
MIME-Version: 1.0
References: <1575361141-6806-1-git-send-email-sj38.park@gmail.com> <1575361141-6806-6-git-send-email-sj38.park@gmail.com>
In-Reply-To: <1575361141-6806-6-git-send-email-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 3 Dec 2019 09:41:47 -0800
Message-ID: <CAFd5g456ZK-zZw_E2O1MOC2-vjwQ8Rpm=tuNMscks_mcOsdwxQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] kunit: Rename 'kunitconfig' to '.kunitconfig'
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     shuah <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 12:19 AM SeongJae Park <sj38.park@gmail.com> wrote:
>
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit renames 'kunitconfig' to '.kunitconfig' so that it can be
> automatically ignored by git and do not disturb people who want to type
> 'kernel/' by pressing only the 'k' and then 'tab' key.
>
> Signed-off-by: SeongJae Park <sjpark@amazon.de>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
