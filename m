Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5627761FB52
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 18:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiKGR1q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 12:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKGR1q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 12:27:46 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A5F12AF9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Nov 2022 09:27:45 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id k2so7574739qkk.7
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 09:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OtwMIMageNgEFgITDbP/X4AlmExFVOD7QsjK39jRkOs=;
        b=ZrBbGd0NE5W3bFjfpMfVEGchJiOqL5vKGUnJZWHQEDCz71oryF6CDiPscJkkJaNeeg
         /pKDfIl6hW5yw8tjgrcZSOwrloCrFqYb1/s9Bc1/cV94xFkaKkZwH1bCSgyaTCtOH5Nq
         2ijwSehO6aXkrD87GuWevIaaXGPhzXmGc/u0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtwMIMageNgEFgITDbP/X4AlmExFVOD7QsjK39jRkOs=;
        b=uLp5lwP/F9PuGhML2UETxFAZfS/j/QjaJgI+RnFOX2d5+yFA+Pyie9FqIVuZFBJO3h
         JRQbANP1asvhPiR8RmOS9fVYJmvNE0Av9AWps1caCKKooY3kgUZ6uRK2rvCHS/A8n7mh
         LN723XSBt31goZQBpMosVQFMu0/4fqWLjgEQMjLJm9EwMuogTTTRx7mIVrKYMJcK8u9C
         tcUBAYwXR6J4MMKZwkkfMxwH06h2+zwYl0yAUaGHPW0qf89gyjbwiqTETk0xFFsoNjqu
         ZhxslW1e36KzBm6t/h1VpKW2+159OS/6m96O7itd/T8mtA3k48vKzUfoIpRqDxl51Pui
         iGAQ==
X-Gm-Message-State: ANoB5pn88iqTypi+S/2h1WFCrWnxHRjCl99vw0Lxa0QIcG8XqDrW36T4
        7sgMEPjJZ0XfTuI6DGK9dOnbsaz0pcVrBA==
X-Google-Smtp-Source: AA0mqf5vuXsKt8UiMD0feSnprxriA+w+G4WuYOctKXtYAiJUgr1LBL0C0XqdEzIspAdIF7U1YBt0/A==
X-Received: by 2002:a05:620a:2087:b0:6fa:ece6:7cc8 with SMTP id e7-20020a05620a208700b006faece67cc8mr2496517qka.616.1667842064205;
        Mon, 07 Nov 2022 09:27:44 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id y20-20020a37f614000000b006cfaee39ccesm7055348qkj.114.2022.11.07.09.27.39
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 09:27:41 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 7so9887211ybp.13
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Nov 2022 09:27:39 -0800 (PST)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr46634218ybu.101.1667842059236; Mon, 07
 Nov 2022 09:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20221107161740.144456-1-david@redhat.com>
In-Reply-To: <20221107161740.144456-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 09:27:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Message-ID: <CAHk-=wj51-dtxf8BQBYP+9Kc3ejq4Y0=-6hCbf_XAnkT3fsgDQ@mail.gmail.com>
Subject: Re: [PATCH RFC 00/19] mm/gup: remove FOLL_FORCE usage from drivers
 (reliable R/O long-term pinning)
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, Nadav Amit <namit@vmware.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 7, 2022 at 8:18 AM David Hildenbrand <david@redhat.com> wrote:
>
> So instead, make R/O long-term pinning work as expected, by breaking COW
> in a COW mapping early, such that we can remove any FOLL_FORCE usage from
> drivers.

Nothing makes me unhappy from a quick scan through these patches.

And I'd really love to just have this long saga ended, and FOLL_FORCE
finally relegated to purely ptrace accesses.

So an enthusiastic Ack from me.

                   Linus
