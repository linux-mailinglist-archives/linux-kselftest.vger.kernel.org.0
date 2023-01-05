Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FEF65F009
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jan 2023 16:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjAEP0i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Jan 2023 10:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234586AbjAEP0T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Jan 2023 10:26:19 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1275C933;
        Thu,  5 Jan 2023 07:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672932374; x=1704468374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OksWkIg+xvN3WL7qYD7ek/Aze8kUo+Yfw829bn01Z/0=;
  b=nZrTdHbnwPLhTs/usRXzb8nZJKnziBCjnqcvnZ5GJFU6OV1l7jiuc01X
   A8JVr+kfOcRJ/yduzVkrlprKYz6a7uAPKxOmOE3hI5YaZWgM2T3LcBIe6
   tzDFmqHMm8Ye70Dyzi4XTVhOzCR5jhffy0kLrBQS3o234vDcx0E+oyAPb
   HTMCYZhdTzlmBq1K2ZiXSqEFJr80DAeiHrbjA+je6AITdzphPbprKqM0U
   zbBnDm5H1GXZwewn/oZDa4W/T19J6GP9zo9gBadWE/0k3wNDq8s3zRIoY
   NmqoZiyrtbvLTpRoXYYqAAwrWx8Z43PDHFxlIVp/QdLyS7BQJJb2DHHCh
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="320939480"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="320939480"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 07:26:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="648967330"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="648967330"
Received: from sbakshi-mobl1.amr.corp.intel.com (HELO [10.212.128.57]) ([10.212.128.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 07:26:13 -0800
Message-ID: <8bbc881b-15ea-1c8a-43ad-423f5a014c99@intel.com>
Date:   Thu, 5 Jan 2023 07:26:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Pavel Boldin <pboldin@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1> <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y7bg5sxEZDIaGoXK@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 1/5/23 06:38, Greg KH wrote:
> But hey, what do I know, I'm not a lawyer which is why I keep insisting
> that one from Intel actually read over this submission and sign-off on
> it to verify that they agree with all of this.

I guess I'm still confused what is triggering the lawyer requirement.
Last time, you asked:

> You are taking source from a non-Intel developer under a different
> license and adding copyright and different license information to it.
> Because of all of that, I have the requirement that I want to know that
> Intel legal has vetted all of this and agrees with the conclusions that
> you all are stating.

To break that down, the earlier submission[1] had:

 * Original developer from a different company
 * Non-GPL original license
 * Relicensing
 * Addition of a new copyright

I can see all of those thing adding up together to trigger the higher
bar of having a lawyer sign off.  It looks like Aaron took that issue
list and tried to improve on it.  This new submission has:

 * Original developer from a different company

Is there anything else in this submission which is triggering the lawyer
review requirement?

If not, I'd be happy to hack up a Documentation patch to describe this
review requirement and make it clear to everyone.  I've gotten traction
with my colleagues in the past once things were fully and clearly
documented.  I'm hoping history repeats itself here.

1. https://lore.kernel.org/all/Y3L2Jx3Kx9q8Dv55@ziqianlu-desk1/
