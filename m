Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5696DFAEA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 18:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjDLQMh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 12:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDLQMd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 12:12:33 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD448A5F;
        Wed, 12 Apr 2023 09:12:28 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 0360132006F2;
        Wed, 12 Apr 2023 12:12:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Apr 2023 12:12:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
        cc:cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681315944; x=1681402344; bh=ig
        gGSzv6t6qQPSvLwa1Px6Q2AiO6aDZaux4wvq90NTY=; b=iKpcflRslOThbWi/Am
        8zvAfFAlarv3e/sa1xLbmEZpnOKZrUsGYJo6KL3dqycsM1XJ2lJtAtsaJ+157anY
        kA42IMrRwEtW17h9x+4lom1dOXtNaFnM+xHx+ToH4DgaRVhRlihzcfclaVvdPBa+
        TJ3D6ZyT2/VsAHHbw82FAwpUhLwZZH5w+LtbUqSgeRvTHYVaZn/aFkc3ycSEkIKt
        FphMD1JMUbb5MRVtlMPgZtbMV7Bhk+eK8zzR010hJwcFemopSHy8ynQQvKGaRYFm
        EBmn1Fck6qyeezSpaWP0wxLBZdQFsqxMkpMGSAzj1ho5P6NdiEVqJ/40jEu/Q/mN
        dkGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681315944; x=1681402344; bh=iggGSzv6t6qQP
        SvLwa1Px6Q2AiO6aDZaux4wvq90NTY=; b=CZtJsZzmFLwcDDvYHzZnrK2nKJqjO
        CqAgG4uUXntYX2WcxmBF3uWm0mKUqHOntpG448b6sPSCQdPR7Hcm5lPvKq/+Od30
        Km8Jzt8Kk8eJWpUOuCdcBCl9NdhFETxJhX0k3Lf3pzHspR8jo9OO2F/MFmOOU5lJ
        lqZkrZEfEJSZ0yyMWGN1zyAJa2eMgirToJ8Rg1+V8Ox51tCxkFXbH6zDZVpAk8pc
        rf5tAD+XszCd42e7zbNQsEMPqEpCYqxlFwambLD7pm7xD6X7jEGotSXVALMIBTql
        vsQDI8bqQup446nXWZmBvCXLO9hjSvVEdRmVYxvspvSxHmNHfK5OfdL5g==
X-ME-Sender: <xms:aNg2ZDFk0V7Mr4U9lsFSmQROAmysGaZBhl41ioiumP-WFBQzXlGY-g>
    <xme:aNg2ZAXLTaK14Zyu13l74BeXfMDkWtHIdRrzpmL4IHx8wyp5WUk2aOHObmDUKZvW9
    F_5B6-YbDdmxeRQ8mA>
X-ME-Received: <xmr:aNg2ZFJHgnXqFjAXTXZ_j84uZwPPkq5WxdBaCGYqclITvLB33Cagk8wdQ_mDtbPuFX9fCIjYggOc7xMhhr-wQdMU0_323cXya01Evnxd1Q6n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpehffgfhvfevufffjgfkgggtsehttd
    ertddtredtnecuhfhrohhmpefuthgvfhgrnhcutfhovghstghhuceoshhhrhesuggvvhhk
    vghrnhgvlhdrihhoqeenucggtffrrghtthgvrhhnpeevlefggffhheduiedtheejveehtd
    fhtedvhfeludetvdegieekgeeggfdugeeutdenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehshhhrseguvghvkhgvrhhnvghlrdhioh
X-ME-Proxy: <xmx:aNg2ZBF2BzUDVb-h2VHuLfxHyQZ9mUGRwFIB-U23xBs7cV5wT_BzKw>
    <xmx:aNg2ZJVPMBoRA96hxzDo5DayxTa3IURfhV3yMHW-3-Q3BqsVTTHnmw>
    <xmx:aNg2ZMNcVKLc9B_UjWtmMXSw0N-eUXv1KvEHCENZLgIlyiDwJbmzAA>
    <xmx:aNg2ZBQ9moIny6YTVcmHK7RFyWWUzgwdV8MT36Qnl4qaObO6fMxKsw>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 12:12:22 -0400 (EDT)
References: <20230412031648.2206875-1-shr@devkernel.io>
 <20230412031648.2206875-2-shr@devkernel.io>
 <ZDawF5FDjgYuEHSX@casper.infradead.org>
User-agent: mu4e 1.10.1; emacs 28.2.50
From:   Stefan Roesch <shr@devkernel.io>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     kernel-team@fb.com, linux-mm@kvack.org, riel@surriel.com,
        mhocko@suse.com, david@redhat.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, akpm@linux-foundation.org,
        hannes@cmpxchg.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v6 1/3] mm: add new api to enable ksm per process
Date:   Wed, 12 Apr 2023 09:08:11 -0700
In-reply-to: <ZDawF5FDjgYuEHSX@casper.infradead.org>
Message-ID: <qvqwfs9513mn.fsf@devbig1114.prn1.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


Matthew Wilcox <willy@infradead.org> writes:

> On Tue, Apr 11, 2023 at 08:16:46PM -0700, Stefan Roesch wrote:
>>  	case PR_SET_VMA:
>>  		error = prctl_set_vma(arg2, arg3, arg4, arg5);
>>  		break;
>> +#ifdef CONFIG_KSM
>> +	case PR_SET_MEMORY_MERGE:
>> +		if (mmap_write_lock_killable(me->mm))
>> +			return -EINTR;
>> +
>> +		if (arg2) {
>> +			int err = ksm_add_mm(me->mm);
>> +
>> +			if (!err)
>> +				ksm_add_vmas(me->mm);
>
> in the last version of this patch, you reported the error.  Now you
> swallow the error.  I have no idea which is correct, but you've
> changed the behaviour without explaining it, so I assume it's wrong.
>

I don't see how the error is swallowed in the arg2 case. If there is
an error ksm_add_vmas is not executedd and at the end of the function
the error is returned. Am I missing something?

>> +		} else {
>> +			clear_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>> +		}
>> +		mmap_write_unlock(me->mm);
>> +		break;
>> +	case PR_GET_MEMORY_MERGE:
>> +		if (arg2 || arg3 || arg4 || arg5)
>> +			return -EINVAL;
>> +
>> +		error = !!test_bit(MMF_VM_MERGE_ANY, &me->mm->flags);
>> +		break;
>
> Why do we need a GET?  Just for symmetry, or is there an actual need for
> it?

There are three reasons:
- For symmetry
- The ksm sharing is inherited by child processes. This allows the test
  programs to verify that this is working.
- For child processes it might be useful to have the ability to check if
  ksm sharing has been enabled
