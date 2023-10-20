Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8197D128E
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Oct 2023 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377658AbjJTPYt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 11:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377652AbjJTPYs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 11:24:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FF191;
        Fri, 20 Oct 2023 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NYhb3tt2EPKODPsCiyKE5j5C9RcaVkLCIwab0yGWNqQ=; b=sllUA0pZVAuRO6ldGt0htyYZ+S
        PdfNDAKQiWXgq9+OMT/8dGd05TAIhP1Z3mbgbvRkprhHySGpBSwIFcOfIlg5bucZLxv6LeAfOBCJy
        ygplxLd3KH4/hblqRD04vmFVrVEVhD5ZDwbfcakMU+s53nCPS6LS1E4kj1nN+KALLkw5maL4StRh+
        Ll7CBTHJsBxup64tpp8Abu+LvWCCRPUR7pEhfaScCCPJmBi9EPePi2cVLnN6ldOW3h2XysgBDi63U
        R1F+Eiyh2fv822mVkkRyMy7+vO3SX5waPF+A+tg0BNsIAsBPB3eS67nkVeSMOa6LmpfimvOryNYXT
        FKTTTJVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtrLv-00DqsE-Bp; Fri, 20 Oct 2023 15:23:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07D40300392; Fri, 20 Oct 2023 17:23:55 +0200 (CEST)
Date:   Fri, 20 Oct 2023 17:23:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, jannh@google.com, sroettger@google.com,
        willy@infradead.org, gregkh@linuxfoundation.org,
        torvalds@linux-foundation.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz,
        xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com,
        dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v2 8/8] selftest mm/mseal mprotect/munmap/mremap/mmap
Message-ID: <20231020152354.GC31411@noisy.programming.kicks-ass.net>
References: <20231017090815.1067790-1-jeffxu@chromium.org>
 <20231017090815.1067790-9-jeffxu@chromium.org>
 <3cf29cd5-8346-419f-88f1-3a5c8ddbacad@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf29cd5-8346-419f-88f1-3a5c8ddbacad@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 20, 2023 at 07:24:03PM +0500, Muhammad Usama Anjum wrote:

> Please remove these. These macros would be picked up from the kernel
> headers automatically.

As per the previous discussions, how does that work if you have O= build
directories?

I find this push to force people to do 'make headers' in order to use
simple selftests quite misguided. You're making it *harder* to use,
leading to less use.
