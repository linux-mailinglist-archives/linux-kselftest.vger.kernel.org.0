Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41753A695B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Sep 2019 15:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfICNH3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Sep 2019 09:07:29 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:42833 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728538AbfICNH3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Sep 2019 09:07:29 -0400
Received: by mail-lf1-f43.google.com with SMTP id u13so12811139lfm.9
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Sep 2019 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9jG0coLUDO+73FdDxlq8YPaOC9hh+AWm0RYXqTFml1I=;
        b=K2W7eoA9Wz1dzyHoTd1E8Ig0xEwSGHpn4TZgk+xkRjkLoqWagIhrdFu/ydhrHNl+r7
         eDtyMNH92Q1EkK+WA5IJVMJJjoW4/sRrS20hWjF7fXcwbDggMU3fq6mL8yOCs+qkYjdS
         XMDnFIAon5TTI7iCCEUKBUAL7X5fZ4iGbWfKdYRvn26eEzLBHMz4li522qixY2/rXih6
         ZfhxKhSWxUNW00O6wAjXdc3wO6/aDBvif0UvL5cdg9IfOJ1GwCFF+AAeCBzHf69yvJGU
         n6TBNc2a+ng/38TVuGyhBWLS2QvxpE0WlMgJbI6YSYe3z+23Pf+0j07HzqltIXP9jDNT
         U/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9jG0coLUDO+73FdDxlq8YPaOC9hh+AWm0RYXqTFml1I=;
        b=m5Nc6Qr9KWlukw9VHKIOEf2w3UvImOvPjplKvnUWYGVzEo4/B+dFQvu4+vmBC01MTH
         bN0oFxt89YxuRsauzFBXbiVAutpdCNgox0ksEz8t1fhdEpdUppjodLDoRCDcRlsDwE1G
         vngqo3oHsRGwUhgu4Tfmls486jcbrwfGC/U/ScBK9SHhJZNTndKPLldwqzum3hcPRmCY
         Z/g1C0mzzmY/DWveDkNbBHgPF9gHGfnmURI1Bva6LA6GrzaP8cctvCLIO/WZc6/Ljs3a
         YBi67oZ376YWfNfc36hqoYiZe4qgE1+/dXuvCv4o//13kazJQatg5U9JOFJGkW0SKXnb
         aKDQ==
X-Gm-Message-State: APjAAAWj5c5oa/p89aYUTKenbnBINLDVefschIhMDLnuIHVkzqJM5h8t
        6zEwb0yeTHS3Udwe6X5j7dNQAeeaCskxYYEbCBRnQGpJBouTuw==
X-Google-Smtp-Source: APXvYqxigTsdHpETjy37tzq9X2RMaXqHknuJqciTLOlma+LwhFBbh1amDf5/SKenJkfYidPYq6hkjcGyPIASWcMKS3g=
X-Received: by 2002:ac2:53b3:: with SMTP id j19mr2134457lfh.182.1567516047134;
 Tue, 03 Sep 2019 06:07:27 -0700 (PDT)
MIME-Version: 1.0
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 3 Sep 2019 15:07:16 +0200
Message-ID: <CADYN=9K6AAC6FsD2aH_SQn3KzvLvZqW6=WgkzyQ9G+KjEdXzow@mail.gmail.com>
Subject: Automated Testing devroom at FOSDEM 2020 poll
To:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Cc:     Cyril Hrubis <chrubis@suse.cz>, Matt Hart <matthew.hart@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello everyone,

We are planning to put together a Automated Testing devroom at FOSDEM
2020 [1] and would like to see if there is any interest in attending
such an event.
If we're not able to put together a set of talks that fills up a (half) day we
shouldn't apply for a devroom.
We have a few people prepared to give talks if the devroom happens.

We would like to know your interest in attending  (or, better yet, make a
proposal to speak or for a discussion session) before 16 September.

Cheers,
Anders
[1] https://fosdem.org/2020/
