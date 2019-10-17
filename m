Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11FCBDBA23
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2019 01:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438541AbfJQX1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 19:27:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36217 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438368AbfJQX1m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 19:27:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id y189so3591168qkc.3
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2019 16:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pUuoIZ98ONzVxfZS360lAsjvw5uM1s/8vVWt8csbw30=;
        b=krIzKB/TPn8CMuxiyBnwuMhxR6abLWjMDKtwJrFup5JXCkSb/NQ5BFJ6iKDc8yC4cp
         LufEjo1SWjFO4T4TG2W7Sp6JHCi/mupjh3DPW51H+XGnvdB15Xu8N2PfAlUhjC8SuD0t
         uJW+F/6l827WxRyNV8IwjphvxM0iTELgXGwRimEpdnzBn7fkW8Uj4i6+d9DMJHv4A2qw
         McBDgNOFTb+6MgYq3tF0mZVZWVQHYs3zYY8ERKodcncc/qNgcJu0tEY6jMkuc0f/xgdO
         gcZ0KxtjBfwkuVcEo8+mOF3m84qqwjIMVqYodP08/BRGLQLyBwd9HoZYcriUdOsP/07n
         r/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pUuoIZ98ONzVxfZS360lAsjvw5uM1s/8vVWt8csbw30=;
        b=bhE5WlRtblT3/VH0DaNQcxmsQ5cB6HIHr7RrJN795JbuCfeMwG3ZpFbamhxyt69X+d
         F92GeC4sPARs/bCiCL/lyMwbbiF8w1nSNGlOGuAM/mGI7dNQtG90JGjfsEnnGULLHBSJ
         1mAZXPOESU91yMKt2HDq72SiMexh6Ts8SvyUQHcttXFf4ZHseX7rDrFojQiUN3xVPiq0
         acP4toj7MxPykUz+ZwUfdRjNCN0zgG7fxRP9+D+uJc0Rzwg2InkobIW+fIP+JyNfXhk8
         M9CglgeB+EKrspY0PoGiVZqHRm4+bFJpS0jUbaIpEeIm+jPTaBWQxVByqfeyL5azVVNh
         04dg==
X-Gm-Message-State: APjAAAW3mjik5/zLC9sd4VGzUXCLf8NpHFXhtleqEQfnJmZzDNdnlhKg
        z+AZsn6DzzGnaeTGuBvUOFZNNG0u7jf52Vs3cVXi
X-Google-Smtp-Source: APXvYqxS4kj6UtGvMthKpyYl6i9PIh7TxBerdY9osXCoPDYr5kZ2vghq8fb1Dr2WCGRfW3tBX17PKgHAy+zLPkJzg/4=
X-Received: by 2002:a37:348:: with SMTP id 69mr5900509qkd.28.1571354861410;
 Thu, 17 Oct 2019 16:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20191010023931.230475-1-yzaikin@google.com> <2f2ea7b0-f683-1cdd-f3f2-ecdf44cb4a97@linuxfoundation.org>
 <CAAXuY3qtSHENgy3S168_03ju_JwAucOAt5WEJGQ+pi5PfurP6g@mail.gmail.com>
 <CAFd5g46RcFV0FACuoF=jCSLzf7UFmEYn4gddaijUZ+zR_CFZBQ@mail.gmail.com>
 <20191011131902.GC16225@mit.edu> <CAFd5g45s1-=Z4JwJn4A1VDGu4oEGBisQ_0RFp4otUU3rKf1XpQ@mail.gmail.com>
 <1e6611e6-2fa6-6f7d-bc7f-0bc2243d9342@linuxfoundation.org>
 <20191017120833.GA25548@mit.edu> <957434b6-32cc-487f-f48e-f9c4416b3f60@linuxfoundation.org>
 <CAAXuY3r7Eu+o-td8MRvexGYmONPgd8FvHr+7mF84Q4ni1G3URg@mail.gmail.com> <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
In-Reply-To: <40073fc9-1de1-9253-e2f9-9cf9ee4308d4@linuxfoundation.org>
From:   Iurii Zaikin <yzaikin@google.com>
Date:   Thu, 17 Oct 2019 16:27:05 -0700
Message-ID: <CAAXuY3r7QKSuwVYDQhF8-zC75ZRVHr+4pzpGXeNbPaEdbM3h4Q@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v2] ext4: add kunit test for decoding
 extended timestamps
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> You can do all of this and allow users to supply another set of data.
> It doesn't gave to be one or the other.
>
What is the use case for running a unit test on a different data set than
what it comes with?
