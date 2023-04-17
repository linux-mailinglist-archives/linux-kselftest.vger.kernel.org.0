Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984306E4E6B
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjDQQkk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjDQQkj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:40:39 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857FE6A7C;
        Mon, 17 Apr 2023 09:40:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F00CF5C01D3;
        Mon, 17 Apr 2023 12:40:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 17 Apr 2023 12:40:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681749637; x=1681836037; bh=BX
        hqaNdZoSfWVMrAt/T4aVq7tNwxkU+VJy/AREti7rM=; b=MzPxUJ3UmwYBJognTb
        XPWvNxa7bzSLI4adjiLIm5xQkLSmahFWwMrI0+oh9osJ+NXS+vlJEwA8b+DKAAGY
        7dLD3t1xFTg5TB0D0z+nR3R3aUAiAxtwPqUGWkaM7UsLgc+LC7SqIDANDRkJjgVv
        EsSbnrUu7W7WMP3PCJ13+9IKcS2zoAlmr2zYCdnor/3DLsD7VQSBc9abuBTKQ0m1
        arhrlxeymtX9GZYv+0Sk1OEMoiH2S1IpvsJY7v2KC8sT9KSQ7dafPMUfmRl/TNne
        guyIN/ul4mN2itFMh6vjm1kCQGqBdg9chAENPyGFReuyGsjoSdTVdL2FVCMTsJum
        kNkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681749637; x=1681836037; bh=BXhqaNdZoSfWV
        MrAt/T4aVq7tNwxkU+VJy/AREti7rM=; b=ZguVOLyfeRNG+jVKyJZD4ON/zyxtV
        NivALjETnZEMOMN+LkELs+wytylULWKs8N2F09xpSIQM8G04U2WTX+67SVTzccqH
        D4IoLrShT264KJqQWFepvv40Ma6tY6JIKV/a7X08q3CmPHiq1jt7sypD1yVbZeXn
        XIQ5uUR9BbmV5HvfPMAg+mI+8jRnEc/BRVSzikFtaymM/gUG0Jqlg+OhZ4IPnT2p
        Mucnw7ILKzq5K6hOlNYQazQJq9DRaPkbbgWEYXXVldn4FiDxbd48lZE7L6J5oAcK
        29jPVt0tJfPnWmHcghHDI1iIRld65jmjU2pym7tDrPU7EpcBVmw3ID7bg==
X-ME-Sender: <xms:hXY9ZLc3Oeh2sfvqyGDDxcc-asZP2Qj_an0YUhcalQWu4g_kc8Hbeg>
    <xme:hXY9ZBM_FZ83uaHeHgPTY2Inijq_zUwqOvBDqkSb5kvSzE6fMlEjdjvUDmAFZ_Oa_
    sVQvBeMhelWWvr1VTQ>
X-ME-Received: <xmr:hXY9ZEhFm2nMCc7iGtQyIxzIkRdf1fChpuBzK7hIS_MtOLdYfulTXZAymWfMimGdPblBJmC7kU-L6BVVRx2fvvs50eXOBRIAQYE1x1kB6uU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:hXY9ZM-bngqK9LuT34gisg5gjf-d5znk0v-YeYaUrbp4nYPKcaDdCw>
    <xmx:hXY9ZHsVnGbmWFFrwCEzTp4xC7TrqPmQemfvwgByRL-UN-wp1oq0Yg>
    <xmx:hXY9ZLFDDORVRB4dU2DtGkhCzxL67WnxU4uD1XU_ZWv2EniPSp0eXQ>
    <xmx:hXY9ZFJOXkYv0yrXE6hxN7oocMV_VlM3v9QgsnIAWvZ0mOg9E2c66Q>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 12:40:36 -0400 (EDT)
References: <20230415225913.3206647-1-shr@devkernel.io>
 <20230415225913.3206647-4-shr@devkernel.io>
 <355f42d1-4354-376d-ab27-7e55d06e64a6@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v8 3/3] selftests/mm: add new selftests for KSM
Date:   Mon, 17 Apr 2023 09:40:19 -0700
In-reply-to: <355f42d1-4354-376d-ab27-7e55d06e64a6@redhat.com>
Message-ID: <qvqw5y9ubgxo.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

>> +/* Verify that KSM can be enabled / queried with prctl. */
>> +static void test_prctl(void)
>> +{
>> +	int ret;
>> +
>> +	ksft_print_msg("[RUN] %s\n", __func__);
>> +
>> +	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
>> +	if (ret < 0 && errno == EINVAL) {
>> +		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
>> +		return;
>> +	} else if (ret) {
>> +		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
>> +	}
>
> Just realized we're missing a "return;" in case of the failure here.
>
I'll fix it in the next version.
