Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2BE6F1CB6
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Apr 2023 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjD1Qhj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Apr 2023 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjD1Qhi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Apr 2023 12:37:38 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF2F46A0;
        Fri, 28 Apr 2023 09:37:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9E77C32004E7;
        Fri, 28 Apr 2023 12:37:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 28 Apr 2023 12:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1682699854; x=1682786254; bh=MK
        +DVxYVvN3aGFxjAA+kdeuA5RkH2tMSRdWjdfgxhi4=; b=Cv33vzwqRcNlMFEPWF
        PU1UKASrD3g0RRDuEazKxFD+Ss6dbx/MzNxqcxOCNCwEfSAPETaDpP7Z6dYbJU9A
        TvtqpuZUOOQSUZSmdHwy9niUbTVRoca2ADpXtMXC2Qwkped5gawIrQhsIZ/czmns
        bZrDK9/41dzRYayBYt1C6f3ZXFq4mRDZiRHEoPoAR079kYZNhwU1b1uo/MvYicbE
        P1kGKFnDVuB9q7KmtCO7/czCxry7O6fjjTbduAPjQLLwks6vYVg0H06YNLVGcjI3
        l1VreTG7tH1GR8/mVUIqzlkH+RhhC4zbY62apxc2YzPuSr5+IrmXw3QP8pcvwLjd
        bm8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682699854; x=1682786254; bh=MK+DVxYVvN3aG
        FxjAA+kdeuA5RkH2tMSRdWjdfgxhi4=; b=Ci7+E8b3jFFPujr459ftatWO7AoLl
        NW4aG1wRCxPYfAPFWbMneqt+v2Me0fxZz4vfabRhAssubeQa1+jD7bI279JaO8vd
        US72syhK0W3PbY0AeWPyKSmKmkwoxN5BgQI+GGB2Mx7HMTDYawfBiPZCQ3ISRVxC
        XFU/paA0Z5HsAa1UNrpMzsv1Quimy9RQvNhMk2z1V2RW1unSIyPl6Vp+iG4Eqjhi
        Qk0ZTlp9fSywv42ixfTR01k9SKWMpbpUibp1uu3e5f+eqcuQO+f3cWDSaedgvH0Q
        LY3B75Uva3RkD/RZXM2rNhwoSPPIf586QYCg84BrxlFHcRrvDx2XTZQRQ==
X-ME-Sender: <xms:TfZLZDqCq5wS_8DOltEKgtdrmOWuTllTZqm41G1Sz_8IqLmljzYz5Q>
    <xme:TfZLZNqqdG17NqcfvHipie_Wk-2CJjhlN2C6BvyJ5lq613bOOClX3aOixtCd3XYay
    PyPJRdYMynqR8prAX8>
X-ME-Received: <xmr:TfZLZAPzhPAN3NWDDW7Joj23y0acmz-VYo2Yh9Ia1GiSiTMQd7gj_U3XDiO6moMrihfCerPvviEFvfgBpgqaH9GYTQClOTrxIY-a7e-6DZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedukedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfhgfhffvvefuffgjkfggtgesth
    dtofdttdertdenucfhrhhomhepufhtvghfrghnucftohgvshgthhcuoehshhhrseguvghv
    khgvrhhnvghlrdhioheqnecuggftrfgrthhtvghrnhepfeeludefhfegvdffieeuhfdvud
    etvdetfefgieegffduhfegffeuudevkeeiuedunecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:TfZLZG6Wl8B72hXV-JwoBT_HgqT4CWuPNN7976QsuvgG6yTS0l7ddQ>
    <xmx:TfZLZC6lXX_f3ScmzJSfmAJ1fVuViam42JSbMPqlgiheHVEpjTzIQw>
    <xmx:TfZLZOhElQjsudGScdYmhrmVEYhu0oON2a6zIx15OvtMbvy1amWZkg>
    <xmx:TvZLZCwIv7t-WGPmelZs7TA-XzXVXQtubFNTJH_023UHVMCiDZM_oQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Apr 2023 12:37:32 -0400 (EDT)
References: <20230418051342.1919757-3-shr@devkernel.io>
 <20230428093659.23962-1-xu.xin16@zte.com.cn>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     xu xin <xu.xin.sc@gmail.com>
Cc:     akpm@linux-foundation.org, bagasdotme@gmail.com, david@redhat.com,
        hannes@cmpxchg.org, kernel-team@fb.com, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mhocko@suse.com, riel@surriel.com, willy@infradead.org,
        yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH v9 2/3] mm: add new KSM process and sysfs knobs
Date:   Fri, 28 Apr 2023 09:27:29 -0700
In-reply-to: <20230428093659.23962-1-xu.xin16@zte.com.cn>
Message-ID: <qvqwjzxwrmif.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


xu xin <xu.xin.sc@gmail.com> writes:

>> This adds the general_profit KSM sysfs knob and the process profit metric
>> knobs to ksm_stat.
>>
>> 1) expose general_profit metric
>>
>>    The documentation mentions a general profit metric, however this
>>    metric is not calculated.  In addition the formula depends on the size
>>    of internal structures, which makes it more difficult for an
>>    administrator to make the calculation.  Adding the metric for a better
>>    user experience.
>>
>> 2) document general_profit sysfs knob
>>
>> 3) calculate ksm process profit metric
>>
>>    The ksm documentation mentions the process profit metric and how to
>>    calculate it.  This adds the calculation of the metric.
>>
>> 4) mm: expose ksm process profit metric in ksm_stat
>>
>>    This exposes the ksm process profit metric in /proc/<pid>/ksm_stat.
>>    The documentation mentions the formula for the ksm process profit
>>    metric, however it does not calculate it.  In addition the formula
>>    depends on the size of internal structures.  So it makes sense to
>>    expose it.
>>
>
> Hi, Stefan, I think you should give some credits to me about my contributions on
> the concept and formula of ksm profit (process wide and system wide),  it's kind
> of idea stealing.
>
>

I wasn't aware the formula that is described in the documentation is
from you. I simply implemented the documented metrics. If you came up
with it, happy to give you credit.

> Besides, the idea of Process control KSM was proposed by me last year although you use
> prctl instead of /proc fs. you even didn't CC my email. I think you should CC my email
> (xu.xin16@zte.com.cn) as least.
>
>> 5) document new procfs ksm knobs
>>
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>  Documentation/ABI/testing/sysfs-kernel-mm-ksm |  8 +++++++
>>  Documentation/admin-guide/mm/ksm.rst          |  5 ++++-
>>  fs/proc/base.c                                |  3 +++
>>  include/linux/ksm.h                           |  4 ++++
>>  mm/ksm.c                                      | 21 +++++++++++++++++++
>>  5 files changed, 40 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> index d244674a9480..6041a025b65a 100644
>> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
>> @@ -51,3 +51,11 @@ Description:	Control merging pages across different NUMA nodes.
>>
>>  		When it is set to 0 only pages from the same node are merged,
>>  		otherwise pages from all nodes can be merged together (default).
>> +
>> +What:		/sys/kernel/mm/ksm/general_profit
>> +Date:		April 2023
>> +KernelVersion:  6.4
>> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>> +Description:	Measure how effective KSM is.
>> +		general_profit: how effective is KSM. The formula for the
>> +		calculation is in Documentation/admin-guide/mm/ksm.rst.
>> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-guide/mm/ksm.rst
