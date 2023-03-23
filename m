Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BD56C6649
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Mar 2023 12:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjCWLPF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Mar 2023 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCWLO7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Mar 2023 07:14:59 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E2E1C5BB;
        Thu, 23 Mar 2023 04:14:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 10D0632007E8;
        Thu, 23 Mar 2023 07:14:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 23 Mar 2023 07:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1679570079; x=
        1679656479; bh=8NrkxqYFn1cmxiBC/AP5l36rNX2XShFZCWb/ANhJcJc=; b=j
        4AZy/sYpJyS0jeLawRXQBN3nDejIyCKw7+YPvm5sbZXe28DbJttLmt8Dr7MoubPd
        MczO7OQHmRTIaiDGzuQh7iqE+UxF8MquHJluhxOqxL71ffiR5UUznEo5pcaJjy8R
        J00fKj165ykVXOtnDKjJ4OYbUJb6wAsicfT0gkziBn6sLf+v6TzlGXWse8eOaT63
        15rZVrErpoAAYHBXVkhrXj6esKIxYIdl6ylllc3IxVAXEv94ZhkvWjFmKkNeI/hA
        gNCG6G61sTOHN+J+PGAV43LdTJv+jjjn+hZkSiU2N12XTMimgP4xmjx4ACQXQKRm
        jeKGrRxgLLIrsPxLUwzxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679570079; x=1679656479; bh=8NrkxqYFn1cmx
        iBC/AP5l36rNX2XShFZCWb/ANhJcJc=; b=aGvqLE1XiTofOZnLpAYDtlJVNnUPW
        FOXKv6RWj29TPsPcsymfn2euI76PK51+3ziiuywNbPLFU93pqI3s447whMl7ie+c
        vpT5RYatyJiwyEO+yEV/o5gkbFS/S8LuKP5U/FIM0EiR0QIgEEnalQKThlDIaelo
        7Nf5CeNLvMjFT1/dknBheyT3EtmdccTHco4LIJnPP2cnN6u0cRMQuY7geBhDpYL4
        DCAMqhMlQWScYc79sevoX6sb2Q8/yWIPVqrL+lSkSs2Ce92PO2klQzgcH6ay8poW
        11sQPQNsMU8Ze7Iu/K405GmuEj4VI4TnP/E8gmdZhP3G5OEe48+oLwYMg==
X-ME-Sender: <xms:nzQcZFy3Hf43sfD6n243uP73VG--x-WNkFk9bZiBhCQmAFbbvtiW7g>
    <xme:nzQcZFTWKf7sekxTXyM8ySjE2lh15U7Rjbw1k9tmLiBE2jkaoEaX1C-f6EBo2QgZJ
    8weHE-tTTPYzgWKpzw>
X-ME-Received: <xmr:nzQcZPURMDPDArRiFDKMDieZEws2Vig2Lcy2hquz3hhJheqNNFZ9lZ5TuSOYv8iBiqmPHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeggedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:nzQcZHgvWUSTJJnQWJgH3hdkIXIBJ_R5vJuahfga3aP10Ki_fnrktw>
    <xmx:nzQcZHDKgkly7khBv_1UA6yFQ0A7tyCqH1mtcaTn-ETB5eLANzU-cw>
    <xmx:nzQcZAJutw4vj90zx_U3teB3-6iA7V-Qc7ENU2kzpKrSBNmgwSSqsw>
    <xmx:nzQcZJ2rFwIgPB2tD6cThSz7D8b5umTVXGk3Rd-AwFn02PKAdt75gw>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Mar 2023 07:14:38 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 2230A109FCC; Thu, 23 Mar 2023 14:14:36 +0300 (+03)
Date:   Thu, 23 Mar 2023 14:14:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/5] selftests/mm: Implement support for arm64 on va
Message-ID: <20230323111436.mj2kbesfxfmvj5by@box.shutemov.name>
References: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323105243.2807166-1-chaitanyas.prakash@arm.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 23, 2023 at 04:22:38PM +0530, Chaitanya S Prakash wrote:
> The va_128TBswitch selftest is designed and implemented for PowerPC and
> x86 architectures which support a 128TB switch, up to 256TB of virtual
> address space and hugepage sizes of 16MB and 2MB respectively. Arm64
> platforms on the other hand support a 256Tb switch, up to 4PB of virtual
> address space and a default hugepage size of 512MB when 64k pagesize is
> enabled.
> 
> These architectural differences require introducing support for arm64
> platforms, after which a more generic naming convention is suggested.
> The in code comments are amended to provide a more platform independent
> explanation of the working of the code and nr_hugepages are configured
> as required. Finally, the file running the testcase is modified in order
> to prevent skipping of hugetlb testcases of va_high_addr_switch.
> 
> This series has been tested on 6.3.0-rc3 kernel, both on arm64 and x86
> platforms.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org 
> 
> Chaitanya S Prakash (5):
>   selftests/mm: Add support for arm64 platform on va switch
>   selftests/mm: Rename va_128TBswitch to va_high_addr_switch
>   selftests/mm: Add platform independent in code comments
>   selftests/mm: Configure nr_hugepages for arm64
>   selftests/mm: Run hugetlb testcases of va switch
> 
>  tools/testing/selftests/mm/Makefile           |  4 +-
>  tools/testing/selftests/mm/run_vmtests.sh     | 12 +++++-
>  ...va_128TBswitch.c => va_high_addr_switch.c} | 41 +++++++++++++++----
>  ..._128TBswitch.sh => va_high_addr_switch.sh} |  6 ++-
>  4 files changed, 49 insertions(+), 14 deletions(-)
>  rename tools/testing/selftests/mm/{va_128TBswitch.c => va_high_addr_switch.c} (86%)
>  rename tools/testing/selftests/mm/{va_128TBswitch.sh => va_high_addr_switch.sh} (89%)

The patchset looks sane to me, but I have question: why arm64 has switch
on 256TB. The reason we have the switch is to keep system backward
compatible.

Maybe it is better to make arm64 switch also on 128TB to make it
compatible across architectures?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
