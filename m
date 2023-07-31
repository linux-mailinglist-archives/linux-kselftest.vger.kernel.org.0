Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E35769443
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 13:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjGaLK1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGaLK0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 07:10:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D69A91BF;
        Mon, 31 Jul 2023 04:10:24 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690801819tz02523v
Received: from [172.18.158.193] ( [61.141.77.223])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 31 Jul 2023 19:08:42 +0800 (CST)
X-QQ-SSF: 01200000000000705000000A0000000
X-QQ-FEAT: iDzLjIm7mlY5kfP5eUcqRNYquvD7LYVk1Gk9HNida7V/ODwDfP9eJbpuZ7+2W
        pwr8duUlmsvPkNnHdMK8TeBoNVfOULVLIpBV9kX1+sHxY8l6n56ksh8vHd8odq3bpCvKa8E
        Qf9V3/iiJXA2+JgwXEQQsGlT2RLkOOvhNL3IGvuF5OpwFFDBTBiOJ5uFM0SFxWViZVahC/k
        d3g/1vv0UgqCsRpQzliNHtVFLj0wid412eoYlK63aKkmGGo7LLKTfGgyF7s6eccH0W1Qce+
        4GDNv+SknQx6D2QTer1LBHPaUu5LZeUCpzyOn8XzmQDgQnDkZTp+FmsVI3hgnk5IVvKm3GG
        gH6FJKLe4Xzhu56DFpBD4jWVc34s/oGKQGfNCxZRUQxuQ/BNFg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13138695526309092015
Message-ID: <171FEADB46C3DEC9+c2940c738cd9e6d64bce2b48eee08a330246e31f.camel@tinylab.org>
Subject: Re: [PATCH v2 0/2] tools/nolibc: add pipe(), pipe2() and their
 testcase
From:   Yuan Tan <tanyuan@tinylab.org>
To:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Cc:     w@1wt.eu, tanyuan@tinylab.org, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Mon, 31 Jul 2023 19:08:41 +0800
In-Reply-To: <f30d3620-cdeb-45be-ba2b-2298a478c5bd@t-8ch.de>
References: <cover.1690733545.git.tanyuan@tinylab.org>
         <f30d3620-cdeb-45be-ba2b-2298a478c5bd@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Thomas,

On Mon, 2023-07-31 at 08:13 +0200, Thomas Weißschuh wrote:
> Hi Yuan!
> 
> On 2023-07-31 13:50:31+0800, Yuan Tan wrote:
> > Thanks to your advice and I really learned a lot from it.
> > 
> > V2 now uses pipe2() to wrap pipe(), and fixes the strcmp issue in
> > test
> > case.
> 
> Thanks!
> 
> I have some more comments for the patches.
> 
> For new revisions you should also link to the old revision.
> 

I sincerely appreciate your valuable advice. As a newcomer, I will
certainly take note of it next time. :)

> > Best regards,
> > Yuan Tan
> > 
> > Yuan Tan (2):
> >   tools/nolibc: add pipe() and pipe2() support
> >   selftests/nolibc: add testcase for pipe
> > 
> >  tools/include/nolibc/sys.h                   | 24 ++++++++++++++
> >  tools/testing/selftests/nolibc/nolibc-test.c | 35
> > ++++++++++++++++++++
> >  2 files changed, 59 insertions(+)
> > 
> > -- 
> > 2.34.1
> > 
> 

