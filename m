Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FFC52DC663
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Dec 2020 19:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgLPSZz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Dec 2020 13:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgLPSZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Dec 2020 13:25:53 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F67C061794;
        Wed, 16 Dec 2020 10:25:13 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id h205so7285107lfd.5;
        Wed, 16 Dec 2020 10:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c3CgEQWtonik7i7WhmRR9yyjT8nXpSj0nE8OYStDFB8=;
        b=DUT18ICrB4JhUwLvZr3G2hSFE/q6fTdjvAVhPDinhkBamoBJnDFhj4Od/qjGZ7jBTf
         RkTighX1kMjbk6AFQ1z1mBmNcQQLstld71ituzaLiQtv88xdr4BL2myeMAvQXoxIzHdY
         2coZdsJ8KtupANz79QKhbAKagTtwSV2fVgqvfOQY9yOGTQ1mNWxfhTBF4LgNm0MxS9Mf
         9pL4gOWg6wzT/Cy/q7CnBwMBQMzDoaeX0nJZGEjfiaa+WHoFNIrdsARJb12wK7IseWhO
         q0YJAmucHjWcjLYYncbFboFDZ3GhuHQPTX2V36N9RcUnm/kt0YGrPnYmpdELCtfoDY8w
         Njqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c3CgEQWtonik7i7WhmRR9yyjT8nXpSj0nE8OYStDFB8=;
        b=CFoqRNT3JrTuPqr62bdZXhDrr9f+JLXBbxrnZaYvchg8F9c02PwOCje0w4Pnhqucag
         BnzFRCwEKhJOPqEK2/pYSrGMGpgUsjcIqwJgqFCHeK8N4vZX2St2qQj71YQ7fk3ogCf1
         D9YwTTPZnoSMFVYHXBZS/6y9XEE5dVuCsaN8uBGK5Vf7HauaJcoWCVKMOHfxDQxVjXlB
         3nPYqiBx7UtFJb9dbuhsQUiM44qx3qLODsXCcFudmSe63m2m1GPsr7FHuUKI1G2+P3XV
         X0USZA/F32vxBPO0Neeu+YcUQra6fv3SawSvq8hAubB1NaeZ9gId18Jq58vCWtX6coMQ
         Y0Mg==
X-Gm-Message-State: AOAM5309Ly1PrVX4DW0eDxNf9AHJ9BcaiEHeXUsMNZF0RpmRtqQTwvxd
        2d3pOtflNWyjdxw979Ujy23xfOwEt/BGu0wNhGc=
X-Google-Smtp-Source: ABdhPJww76Acs8JQrEXmG5podBxo/+oZp9geBXky0wxgfhDEThf2XF6oZuXZwmctBefOoqg5eedFQOcDUQcE0FSLnYk=
X-Received: by 2002:a05:6512:210c:: with SMTP id q12mr12982443lfr.601.1608143111015;
 Wed, 16 Dec 2020 10:25:11 -0800 (PST)
MIME-Version: 1.0
References: <30d39293-80a4-9ef5-92bb-6b6dec464be3@toxicpanda.com> <mhng-2da5b1a2-20f9-4b0e-9ffd-7f60a161ebf0@palmerdabbelt-glaptop>
In-Reply-To: <mhng-2da5b1a2-20f9-4b0e-9ffd-7f60a161ebf0@palmerdabbelt-glaptop>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Wed, 16 Dec 2020 13:24:59 -0500
Message-ID: <CAGF4SLgDvS7VOih4XZ+sqx6jVK3wBQZan+uZMVsdYdVEPZdrpw@mail.gmail.com>
Subject: Re: [dm-devel] [PATCH v1 0/5] dm: dm-user: New target that proxies
 BIOs to userspace
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     josef@toxicpanda.com, bvanassche@acm.org,
        Christoph Hellwig <hch@infradead.org>,
        Mike Snitzer <snitzer@redhat.com>, corbet@lwn.net,
        kernel-team@android.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>, dm-devel@redhat.com,
        linux-kselftest@vger.kernel.org, shuah@kernel.org, agk@redhat.com,
        michael.christie@oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 14, 2020 at 10:03 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:

> I was really experting someone to say that.  It does seem kind of silly to build
> out the new interface, but not go all the way to a ring buffer.  We just didn't
> really have any way to justify the extra complexity as our use cases aren't
> that high performance.   I kind of like to have benchmarks for this sort of
> thing, though, and I didn't have anyone who had bothered avoiding the last copy
> to compare against.

I worked on something very similar, though performance was one of the
goals. The implementation was floating around lockless ring buffers,
shared memory for zerocopy, multiqueue and error handling. It could be
that every disk storage vendor has to implement something like that in
order to bridge Linux kernel to their own proprietary datapath running
in userspace.

-- 
wbr, Vitaly
