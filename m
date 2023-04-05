Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442FA6D8991
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Apr 2023 23:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbjDEVbZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Apr 2023 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDEVbY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Apr 2023 17:31:24 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B086C1FD2;
        Wed,  5 Apr 2023 14:31:22 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5EC4A5C004D;
        Wed,  5 Apr 2023 17:31:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 17:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1680730280; x=1680816680; bh=FB
        IggV7bE2CLxugCSVAleO54ungHAYPbbVABvtF3t4Y=; b=XrSaSnmROk71DrVAgi
        QmaTrjH4ETY1+XoaYuRJISZ/pI/FZ5ogcvfPc3kfssPQTCq9eHdtQqvFzOAws4LQ
        AVCrr5fdjpyebktlfht9lRIwiVqMzbVsJx5dNTOuNOI+NSAYENu7u/kOiuDPFvU+
        bs90sgOkIgjJrRcFJj0bRlsMV5BGiGsgktHdRHZsHcSZ6y7/nIGvBhQR49uDywRz
        S3jUXfXyKxvKgpGdZsGrSorBQSyCEjDt1IUlynLMjmEeSJB2T94mnP5XHsw9xqmG
        FJTtgg1S59Y8dQfRqVh6A/RFZVCTGwR5ZyD+EAyoOEoJO/h97btZW9xT7ivphuRQ
        aCmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680730280; x=1680816680; bh=FBIggV7bE2CLx
        ugCSVAleO54ungHAYPbbVABvtF3t4Y=; b=J3pbKhKZpku2ttX/Un7hljU+h05pI
        mSUGgJ3yq2bCMjFCMmq/T8DGVhEqHXciNetD7Kz6wCJsvgNcKKQKF3Ex8bPqA66f
        G5h2NTpTyTP7bGpUp12Uw52KlNAlGb2RSXNozjVP8tabnT3OF7GbwYaww5IJGNvV
        cDxiAjln5DmEsyQsgYHB7XVvC889XA4UGSSxiMAffkX6DrcIF4bmq6vsBWOXbhPK
        OBXd57da3RHUIFT7wBHfKX+5MCzDameHrggblkwkMrhwEy5dOXI8dVrj2fJ5cZYr
        6i28cejyVq5Vbv+npic9anZOThz14bMlodLShhLTju6YSog54YAdWMNnw==
X-ME-Sender: <xms:p-gtZPZE1s3w3XFFFSRKtJeliyTMAHqsjWxxdY1mxCDJwrZaQwExKg>
    <xme:p-gtZOZ87lRmI5gAi8vY8iozZYq1iczT50yKLCQUviM0TqVWJJ8aOKG8jQujoaOk9
    MZtxGlfzh6aNqUyLOQ>
X-ME-Received: <xmr:p-gtZB8qKv0sgZhGPCuLJ7mDNZF13NIVaJkzF4V78x9cxmxJSvhkqYpRu6anWueHntoKjjnMuYZEB6fMDh7KRjgPE4j2kEOveTOjuJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgudeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpehffgfhvfevufffjgfkgggtsehttdertddtredtnecuhfhrohhmpefuthgv
    fhgrnhcutfhovghstghhuceoshhhrhesuggvvhhkvghrnhgvlhdrihhoqeenucggtffrrg
    htthgvrhhnpefhgfejveduudehvdduvefguddvffefgffhieeuudefudfhhfeijeefjeff
    heelvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhesuggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:p-gtZFo1Q6jHodbYR5BJ3ljPrM2IuXmwaWFEDk6euVESEWBbrvZ74A>
    <xmx:p-gtZKpXyH2VIbbhurLnMSmCOAzUS0XUJoO044E-V7TDCmv0N_jyyw>
    <xmx:p-gtZLSrrkp8jHthTj3BrCa7zuSp2h3HV8HNMA50HtG5LPDrZ_qDUQ>
    <xmx:qOgtZGfYw4kZpgtr2UHURlUOK-pgSrpC3obPXXmFkY-u_HvAE86sRA>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 17:31:18 -0400 (EDT)
References: <20230310182851.2579138-1-shr@devkernel.io>
 <20230310182851.2579138-3-shr@devkernel.io>
 <ce494e5a-3540-d6ad-4e9c-0bb49c7e1e1b@redhat.com>
User-agent: mu4e 1.6.11; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     David Hildenbrand <david@redhat.com>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 2/3] mm: add new KSM process and sysfs knobs
Date:   Wed, 05 Apr 2023 14:20:27 -0700
In-reply-to: <ce494e5a-3540-d6ad-4e9c-0bb49c7e1e1b@redhat.com>
Message-ID: <qvqw8rf6uicf.fsf@dev0134.prn3.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


David Hildenbrand <david@redhat.com> writes:

> On 10.03.23 19:28, Stefan Roesch wrote:
>> This adds the general_profit KSM sysfs knob and the process profit metric
>> and process merge type knobs to ksm_stat.
>> 1) split off pages_volatile function
>>     This splits off the pages_volatile function.  The next patch will
>>     use this function.
>> 2) expose general_profit metric
>>     The documentation mentions a general profit metric, however this
>>     metric is not calculated.  In addition the formula depends on the size
>>     of internal structures, which makes it more difficult for an
>>     administrator to make the calculation.  Adding the metric for a better
>>     user experience.
>> 3) document general_profit sysfs knob
>> 4) calculate ksm process profit metric
>>     The ksm documentation mentions the process profit metric and how to
>>     calculate it.  This adds the calculation of the metric.
>> 5) add ksm_merge_type() function
>>     This adds the ksm_merge_type function.  The function returns the
>>     merge type for the process.  For madvise it returns "madvise", for
>>     prctl it returns "process" and otherwise it returns "none".
>> 6) mm: expose ksm process profit metric and merge type in ksm_stat
>>     This exposes the ksm process profit metric in /proc/<pid>/ksm_stat.
>>     The name of the value is ksm_merge_type.  The documentation mentions
>>     the formula for the ksm process profit metric, however it does not
>>     calculate it.  In addition the formula depends on the size of internal
>>     structures.  So it makes sense to expose it.
>> 7) document new procfs ksm knobs
>>
>
> Often, when you have to start making a list of things that a patch does, it
> might make sense to split some of the items into separate patches such that you
> can avoid lists and just explain in list-free text how the pieces in the patch
> fit together.
>
> I'd suggest splitting this patch into logical pieces. For example, separating
> the general profit calculation/exposure from the per-mm profit and the per-mm
> ksm type indication.
>

Originally these were individual patches. If I recall correctly Johannes
Weiner wanted them as one patch. I can certainly split them again.

>> Link: https://lkml.kernel.org/r/20230224044000.3084046-3-shr@devkernel.io
>> Signed-off-by: Stefan Roesch <shr@devkernel.io>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Rik van Riel <riel@surriel.com>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>
>
> [...]
>
>>   KSM_ATTR_RO(pages_volatile);
>>   @@ -3280,6 +3305,21 @@ static ssize_t zero_pages_sharing_show(struct kobject
>> *kobj,
>>   }
>>   KSM_ATTR_RO(zero_pages_sharing);
>>   +static ssize_t general_profit_show(struct kobject *kobj,
>> +				   struct kobj_attribute *attr, char *buf)
>> +{
>> +	long general_profit;
>> +	long all_rmap_items;
>> +
>> +	all_rmap_items = ksm_max_page_sharing + ksm_pages_shared +
>> +				ksm_pages_unshared + pages_volatile();
>
> Are you sure you want to count a config knob (ksm_max_page_sharing) into that
> formula? I yet have to digest what this calculation implies, but it does feel
> odd.
>

This was a mistake. I wanted ksm_pages_sharing instead of
ksm_max_page_sharing.

>
> Further, maybe just avoid pages_volatile(). Expanding the formula (excluding
> ksm_max_page_sharing for now):
>
>
> all_rmap = ksm_pages_shared + ksm_pages_unshared + pages_volatile();
>
> -> expand pages_volatile() (ignoring the < 0 case)
>
> all_rmap = ksm_pages_shared + ksm_pages_unshared + ksm_rmap_items -
> ksm_pages_shared - ksm_pages_sharing - ksm_pages_unshared;
>
> -> simplify
>
> all_rmap = ksm_rmap_items + ksm_pages_sharing;
>
I'll simplify it.

> Or is the < 0 case relevant here?
>

A negative profit is ok.

>> +	general_profit = ksm_pages_sharing * PAGE_SIZE -
>> +				all_rmap_items * sizeof(struct ksm_rmap_item);
>> +
>> +	return sysfs_emit(buf, "%ld\n", general_profit);
>> +}
>> +KSM_ATTR_RO(general_profit);
>> +
>>   static ssize_t stable_node_dups_show(struct kobject *kobj,
>>   				     struct kobj_attribute *attr, char *buf)
>>   {
>> @@ -3345,6 +3385,7 @@ static struct attribute *ksm_attrs[] = {
>>   	&stable_node_dups_attr.attr,
>>   	&stable_node_chains_prune_millisecs_attr.attr,
>>   	&use_zero_pages_attr.attr,
>> +	&general_profit_attr.attr,
>>   	NULL,
>>   };
>>
>
> The calculations (profit) don't include when KSM places the shared zeropage I
> guess. Accounting that per MM (and eventually globally) is in the works. [1]
>
>
> [1]
> https://lore.kernel.org/lkml/20230328153852.26c2577e4bd921c371c47a7e@linux-foundation.org/t/
