Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1E76BE5F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 22:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjHAURi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 16:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHAURi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 16:17:38 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 686A6E71;
        Tue,  1 Aug 2023 13:17:36 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 371KHStg021073;
        Tue, 1 Aug 2023 22:17:28 +0200
Date:   Tue, 1 Aug 2023 22:17:28 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     Yuan Tan <tanyuan@tinylab.org>, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/2] tools/nolibc: add pipe(), pipe2() and their
 testcase
Message-ID: <20230801201728.GA20284@1wt.eu>
References: <cover.1690903601.git.tanyuan@tinylab.org>
 <d8591760-8a00-4837-bc4b-21418ac7a5d6@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8591760-8a00-4837-bc4b-21418ac7a5d6@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Tue, Aug 01, 2023 at 05:42:57PM +0200, Thomas Weiﬂschuh  wrote:
> 
> Aug 1, 2023 17:40:01 Yuan Tan <tanyuan@tinylab.org>:
> 
> > Hi Willy and Thomas,
> >
> > In v3, I have fixed all the problems you mentioned.
> >
> > Welcome any other suggestion.
> >
> > ---
> > Changes in v3:
> > - Fix the missing return
> > - Fix __NR_pipe to __NR_pipe2
> > - Fix the missing static
> > - Test case works in one process
> > - Link to v2:
> > † https://lore.kernel.org/all/cover.1690733545.git.tanyuan@tinylab.org
> >
> > Changes in v2:
> > - Use sys_pipe2 to implement the pipe()
> > - Use memcmp() instead of strcmp()
> > - Link to v1:
> > † https://lore.kernel.org/all/cover.1690307717.git.tanyuan@tinylab.org
> >
> > ---
> > Yuan Tan (2):
> > † tools/nolibc: add pipe() and pipe2() support
> > † selftests/nolibc: add testcase for pipe
> >
> > tools/include/nolibc/sys.h†††††††††††††††††† | 24 ++++++++++++++++++++
> > tools/testing/selftests/nolibc/nolibc-test.c | 22 ++++++++++++++++++
> > 2 files changed, 46 insertions(+)
> 
> For the full series:
> 
> Reviewed-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thank you both, now queued on top of the rest in 20230801-nolibc-next-1.
Thomas I'll try to review your last series tomorrow, at first glance it
looks OK.

Thanks,
Willy
