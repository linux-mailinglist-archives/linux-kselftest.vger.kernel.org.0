Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEEB6A47BE
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Feb 2023 18:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjB0RTu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Feb 2023 12:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjB0RTq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Feb 2023 12:19:46 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B2C231D7;
        Mon, 27 Feb 2023 09:19:43 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 210CB5C0151;
        Mon, 27 Feb 2023 12:19:43 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 Feb 2023 12:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1677518383; x=1677604783; bh=2KV2La5q/D
        qWCaZ/mIakX9SOJHTyUegWIB2oGRp45EM=; b=iCh95RP/dgMhQGd5JVuOXlgHTu
        W7sMt/FoQZv34zgj+0vKho8z/CwBFJQNJK4JyN7kzaOCAGQzcA7DyNVcuN67fXwW
        3KzCu/yHg64d43UWDUXd10EWbrs1P8W4r915aAjdOq1Ng1DSzPUqjIdYkEt9Kbcq
        +XtWIdtjshGg2P+2OwUPN7doZx/Ih04beqsgHZng+7eUJs6axd6OLI1u0QJV8/Ne
        PrrsWk2qYWxo4ieecG3yQhrzNIbJf9MFClbK1B85W+qGkUE4qLGUcsgydRkD5yGo
        KWTwHVbtIO6GgYo5KiWRFGo74dD+HIBVcWwH5s6poZbb/pothfWx8Ns8frLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1677518383; x=1677604783; bh=2KV2La5q/DqWCaZ/mIakX9SOJHTy
        UegWIB2oGRp45EM=; b=hEBxJHOwYlhMS4yGqrmvWLLSe7Ni5e5E73gEg/LOQHiE
        PSctUELXVMcZKn9fyTsDY5ICwqybRcDWkIKZFKd855w6h1h5iciXcPlifRbzvwSv
        pmOObOaFxYfaLdcCFvJILCbcE56156cKVxY9KLCbiOYkjh68AyBqznJAO8Q5R95Z
        a2dBVGuvtmXcfbVClJhyhl6l5Dz0S/5x4kklCN2Gk5nYnwiG7VBI+wEtr5/4e8eH
        F5bETPg6tT7x44IYyjGtg6sMRXF4KUWtLj5/gKOvAOlUQ7BOOz8jkFP8J+UDfrqe
        JOotDmt6zyjLlaJgh1och+mITUjNRYDsqUfQFtc9XQ==
X-ME-Sender: <xms:Lub8Y24c0mREo4Gi0uxu-gPI_vwdHRwMSRCd2phW6QPI_6CYTVAbjw>
    <xme:Lub8Y_4KX5TizTUJne15BZXcBNBCqB5T_tqjhYKguILLN8-lBq1mPFYrUMTdrbTYT
    6kKhxjOCQaDgaScZjk>
X-ME-Received: <xmr:Lub8Y1c64O02RK7TONfKP8sAkTZqjOtKbGJIQDwRrgdfkqmlO4qZqxv8NZPT1zMd8pinv-tFgwLmVwsV6NuV3r6Sk6vPQUO2qaqQD1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeltddgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfhgfhffvvefuffgjkfggtgesthdtredttdertdenucfhrhhomhepufhtvghf
    rghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrfgrth
    htvghrnhepveelgffghfehudeitdehjeevhedthfetvdfhledutedvgeeikeeggefgudeg
    uedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsh
    hhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:Lub8YzJt-js5SDMrFYmNHZb9lCYZQLdLUtW8IZgcsei-X-w2s5K6Wg>
    <xmx:Lub8Y6IuF8qgPyhT3ZV4pSvsUVUJPBImibB1e0OqwZkjSnrwR9GF6w>
    <xmx:Lub8Y0wDA9qNHC5bVv1hlm18sOyF8KC7Lyj-SeR3XN9E3gh3h8qPjw>
    <xmx:L-b8Y59mfm3e986SWpyX6U3SJSH059QEbgIF0qS2zBUP0yhgqRN4zA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Feb 2023 12:19:41 -0500 (EST)
References: <20230224044000.3084046-1-shr@devkernel.io>
 <20230224044000.3084046-4-shr@devkernel.io>
 <20230225213027.69c27e7790898c32e66312ea@linux-foundation.org>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, hannes@cmpxchg.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v3 3/3] selftests/mm: add new selftests for KSM
Date:   Mon, 27 Feb 2023 09:19:16 -0800
In-reply-to: <20230225213027.69c27e7790898c32e66312ea@linux-foundation.org>
Message-ID: <qvqwa60zhvpw.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Andrew Morton <akpm@linux-foundation.org> writes:

> On Thu, 23 Feb 2023 20:40:00 -0800 Stefan Roesch <shr@devkernel.io> wrote:
>
>> This adds three new tests to the selftests for KSM. These tests use the
>> new prctl API's to enable and disable KSM.
>>
>> ...
>>
>> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
>> index d90cdc06aa59..507cb22bdebd 100644
>> --- a/tools/testing/selftests/mm/Makefile
>> +++ b/tools/testing/selftests/mm/Makefile
>> @@ -29,7 +29,8 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>>  # LDLIBS.
>>  MAKEFLAGS += --no-builtin-rules
>>
>> -CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>> +CFLAGS = -Wall -I $(top_srcdir)/tools/include/uapi
>> +CFLAGS += -I $(top_srcdir) -I $(top_srcdir)/usr/include $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>>  LDLIBS = -lrt -lpthread
>>  TEST_GEN_FILES = cow
>>  TEST_GEN_FILES += compaction_test
>
> This change runs afoul of the recently merged 8eb3751c73bec
> ("selftests: vm: Fix incorrect kernel headers search path").
>
> I did this:
>
> --- a/tools/testing/selftests/mm/Makefile~selftests-mm-add-new-selftests-for-ksm
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -29,7 +29,7 @@ MACHINE ?= $(shell echo $(uname_M) | sed -e 's/aarch64.*/arm64/' -e 's/ppc64.*/p
>  # LDLIBS.
>  MAKEFLAGS += --no-builtin-rules
>
> -CFLAGS = -Wall -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> +CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
>  LDLIBS = -lrt -lpthread
>  TEST_GEN_FILES = cow
>  TEST_GEN_FILES += compaction_test
> _
>
> But I expect it's a bit wrong.  Please check?
This change looks good.
