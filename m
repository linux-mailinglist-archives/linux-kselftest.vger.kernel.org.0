Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22C006E4E80
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Apr 2023 18:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDQQnI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Apr 2023 12:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjDQQnH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Apr 2023 12:43:07 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D117D84;
        Mon, 17 Apr 2023 09:43:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 49C1D5C007C;
        Mon, 17 Apr 2023 12:43:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 17 Apr 2023 12:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1681749786; x=1681836186; bh=YD
        e3y1T8NWWsjl/y28nmrnwl6G1y0u8s1lFy/i0ih80=; b=b+MrrqmkqnhWnXyJzS
        +Hug34CJDBjbLk5mJEQi4cnFU/leVEaDstO0jkZZv3DZGS+QaNMEacn1E5hS985x
        Rq2B/cmHgqjyF4t7EUcQ4IYgKTn9Km0262ErSAjFO2o/xjf/VhWNKnJjRenYuXBN
        0US8Hr6b1oGQTDDh2PHEGXr9MntmpuCfdqOVQHadrOP3U48KHXHIS3eQ9rQe4HFb
        wPN9xBMC7Ow5GuwKFEfSyOjTRoE7QXT61XkipHiu7kQe0ku/JH3GTs6Z9ppHkqn2
        xGqVINFBYcGV9EicZAhEHzSjx3ny7545Okc25v4sGXa/YBP40GxWpMYV1+CBf/Sq
        hyRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681749786; x=1681836186; bh=YDe3y1T8NWWsj
        l/y28nmrnwl6G1y0u8s1lFy/i0ih80=; b=OmXJCtZ0e8x+NUyE3P6D2U2F1NBIO
        dzCNJxBz85VvpX8WrqJOEZ1yp1D65nsJkLziTq8BrS4FmYvZgbxQ2G7R27EAWv21
        0bx/yjSHqzRK8w8ZWaVp0WXL7frKJrHxZ2/wutn09xDw25NAvtTjmGeNpAG4pukv
        ipewXi0x7D6siNWcJXqVqOCdICB0mjdMktmqEp4mXCKz2gY5quwFRpxnW+SP6oFp
        eGxJ/kwLoB7YWA2CedgOceSWdbTP/bJwfDKYhnhXKGEptW/AxGPjYCG00JDU8l85
        7UwsDoKqsDbsCopDPLy3xXsB6RxhyAJLqVBFaLEjZvkmzTedafLd6ojPw==
X-ME-Sender: <xms:GXc9ZDd7ys3en2ywRjBvRYO3KyL-7CVOwfu2fx7HfTJTnrfsyOYTdA>
    <xme:GXc9ZJP8kxrLKNvJOfaiEGJETZ0ugIRgwb0mjCQxutJPIHCV4F88HFrEuA0fpcW9q
    zTp9iyGl6pr4OCcqus>
X-ME-Received: <xmr:GXc9ZMj00o7AxdE8HsTepTFIaVI9nrbjelpIIea6TOL--SJQ5GSxcWfP3Z8tQHc2xE4e8nj62G1lsELIhj3OkvPHsrU_gmwTFHWXEk3igMPI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeliedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpeevlefggffhheduiedtheejveehtdfhtedvhfeludetvdegieekgeeggfdu
    geeutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:GXc9ZE9VAbXr0Oyq6ogSh_COHTHLrwA2XJfbDaUjP2Q5W3w_QLWhDg>
    <xmx:GXc9ZPsQTqeXsUcrOo92rHCOuYyRSjhVxd1hIh5ulpnGPhA_ZB7dcQ>
    <xmx:GXc9ZDFZyTH4Y-FB8pFdwyRY7CiS-9ov_tYC61NK96yGyoqf9FLQnw>
    <xmx:Gnc9ZNJn4lxCpTZL4eruSA2Zoy52vH0BY-M6SIR2CU2C9VMwL4BZKA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Apr 2023 12:43:04 -0400 (EDT)
References: <20230415225913.3206647-1-shr@devkernel.io>
 <20230415225913.3206647-4-shr@devkernel.io>
 <355f42d1-4354-376d-ab27-7e55d06e64a6@redhat.com>
 <954d6b1f-5b4d-48e5-02fe-646b3e79f6e5@redhat.com>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v8 3/3] selftests/mm: add new selftests for KSM
Date:   Mon, 17 Apr 2023 09:42:39 -0700
In-reply-to: <954d6b1f-5b4d-48e5-02fe-646b3e79f6e5@redhat.com>
Message-ID: <qvqw1qkibgtk.fsf@devbig1114.prn1.facebook.com>
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

> On 17.04.23 16:35, David Hildenbrand wrote:
>>> +/* Verify that KSM can be enabled / queried with prctl. */
>>> +static void test_prctl(void)
>>> +{
>>> +	int ret;
>>> +
>>> +	ksft_print_msg("[RUN] %s\n", __func__);
>>> +
>>> +	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
>>> +	if (ret < 0 && errno == EINVAL) {
>>> +		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
>>> +		return;
>>> +	} else if (ret) {
>>> +		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
>>> +	}
>> Just realized we're missing a "return;" in case of the failure here.
>>
>
>
> And we should probably fix that as well:
>
> ERROR: do not initialise globals to 0
> #235: FILE: tools/testing/selftests/mm/ksm_tests.c:57:
> +int debug = 0;
>
> total: 1 errors, 0 warnings, 512 lines checked

I'll fix it in the next version.'
