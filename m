Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195917D87D1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 19:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjJZRua (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 13:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjJZRu3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 13:50:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BCD1B8;
        Thu, 26 Oct 2023 10:50:24 -0700 (PDT)
X-QQ-mid: bizesmtp74t1698342618tq9j2vye
Received: from linux-lab-host.localdomain ( [119.123.131.231])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 27 Oct 2023 01:50:17 +0800 (CST)
X-QQ-SSF: 01200000000000E0Y000000A0000000
X-QQ-FEAT: +ujAKkuGAaX5KeGXRyf5UpdCEUMEpYR4BgTrpPl9gpoOLh3KNZTFK7GU4xvfn
        EW15B+5LhGz/nhP/jqP2Zntj5WUnk8PuYFtP5AUFGZqt0eVINWhapd6VbsOXpzUCH+pQ+SX
        wwdWOZS+U4kDDE6OS7rIPbpdp7ttdWKSUAX/OHGBXH0J3Gcamd99wdzZ2NZygxoUQI44pBA
        wadQWSEm40/OEbMCyq1u/m1ef03GbVEpQosAFtvQRkACJ9vPxuPyKrwUHzCMwwHamQVM9fw
        /5aHcq5iFepriB3cme/OAgQEI/TVgloZ4GMfAstE7ZCcgIJOQuUUuG//LsOFHx6pLzj+lOm
        0UDllCQH9fxHDNwARvNXf8qwgjU6AQsJO1u0Fp5vS6ymk2jtDM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2069114788054372621
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        shuah@kernel.org, w@1wt.eu
Subject: Re: [PATCH 4/5] selftests/nolibc: support out-of-tree builds
Date:   Fri, 27 Oct 2023 01:50:12 +0800
Message-Id: <20231026175012.198234-1-falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2fc4054a-ab4f-40c8-b378-1423751031f5@t-8ch.de>
References: <2fc4054a-ab4f-40c8-b378-1423751031f5@t-8ch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: Yes, score=6.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [43.154.54.12 listed in list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [43.154.54.12 listed in bl.score.senderscore.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi, Thomas

> Oct 22, 2023 11:31:32 Willy Tarreau <w@1wt.eu>:
> 
> > (...)
> >
> > I think you should add a Suggested-by at least since Zhangjin attempted
> > that work quite a few times already and allowed to make progress in that
> > direction (maybe even co-developed, I'm not sure).
> 
> Indeed. For a proper Co-developed-by I also need
> a Signed-off-by by Zhangjin.
> 
> Zhangjin, are you fine with giving me one for this
> patch?
>

It is ok for me, thanks very much to make it really works!

BR,
Zhangjin Wu

> > Acked-by: Willy Tarreau <w@1wt.eu>
> 
> Thanks!
