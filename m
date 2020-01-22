Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C93AA14591B
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2020 16:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgAVP4i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jan 2020 10:56:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34729 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgAVP4i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jan 2020 10:56:38 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so6522325oig.1;
        Wed, 22 Jan 2020 07:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=R4YvNeAxb3+eLRoT3iNAV5v/H9LROR+XP6+YqY0F8A0=;
        b=sVdqrKFomB0aPeYSCV23RAlQHynJ8Zh5XM40HaNxdWx9s/kFaiywgVYg9uiA8EeyCK
         uifR+qxkaEvNvBTzJKm5nkOBOXL3xKtu50MxEj17aV6rdc0owS8WOv4LnE0Gi3U5yzv9
         mw7hkNqEAJn5wGVwzGSI0JM8bB4uapHL/RjpBiqMFaFfUZ1nqmjR5+AI9aJcev/JpQ46
         6X7/cmTP/1JcGDpWlsWFoMMs+fxJQg5PQIiFhcJQlPHgXHD27vkEbt2F1Xlb8RYWwnAj
         Dy4itGviB3qcHbwLv+Hr5Zo3dthpj1twcZ/KIM2zgdrIv1QkUO8aWdGzS2v2/AATuVr/
         o84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=R4YvNeAxb3+eLRoT3iNAV5v/H9LROR+XP6+YqY0F8A0=;
        b=RqBc+xQyJWURtMcYKX0fGWSY3A80CtIfcvA1RJdZpg07aaLccsfEiULB8F3sMwtwhN
         WqrajYQbDc4nHJyvjmQ0TrDFjrBdSYFQJfWTCAVOgaeCmzdS096t3Ye8A9cfLBQ9O2+/
         DC8E21BV/piETiUl4yILWGkVhOJRk29jLUI4GZJnksphs+EVVTvyhKFJcAXctOEFwHpW
         +x15c2YxtoMf+DSg0UNaAEsPeGhiu/HJDKrloqos3Ia0RgmwRJjS3q5yhVqsuCBbZfTg
         YonDoq/tOOnJb79mccF4lGLR/mayEfehfApRi5f1PU0zjOPcUT07A3no9ngRdn8EXTTl
         bI/A==
X-Gm-Message-State: APjAAAWotUPCv/OP2jifQ6m42piqNtBlxbzv7KF8LZWYVnCWl3GGcF1e
        ia6X62WZ/r7U3Wip+SygmV0QIQX11twTtcE7Y6Thjcc2JJ6LeA==
X-Google-Smtp-Source: APXvYqzHRs45g0og3SLdnL+tfRY0UJ1urZmaXCSg4tzMqQCf9ZF8Uoir744AldMq2KxxR1+23k1YwTfGz2vs8JLKw8k=
X-Received: by 2002:a05:6808:2c4:: with SMTP id a4mr7000891oid.22.1579708097962;
 Wed, 22 Jan 2020 07:48:17 -0800 (PST)
MIME-Version: 1.0
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Wed, 22 Jan 2020 16:48:06 +0100
Message-ID: <CAODFU0pi6MVJ+XgUmZRS_+ihAyZF+aq_V7sdnbeNeDtPzCZS=A@mail.gmail.com>
Subject: Re: [RFC PATCH v1] pin_on_cpu: Introduce thread CPU pinning system call
To:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hello

I would like to note that this does not help userspace to express
dynamic scheduling relationships among processes/threads such as "do
not run processes A and B on the same core" or "run processes A and B
on cores sharing the same L2 cache".

Sincerely
Jan
