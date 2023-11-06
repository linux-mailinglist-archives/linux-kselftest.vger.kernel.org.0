Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D4F7E2AEA
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 18:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbjKFRZZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 12:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjKFRZY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 12:25:24 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA129D61;
        Mon,  6 Nov 2023 09:25:21 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A6BpQj7023965;
        Mon, 6 Nov 2023 11:24:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        PODMain02222019; bh=CVbUBIpIxyqe8kEZvNlbRU+/Ur+5QwTHAOujrGRDYN0=; b=
        R2XTlkRAHZzajiApAbqXUUHWuiFyAU/qYZ55SH7YIQl1rxqgGD06TXqmAYAjUoXB
        63yw307TuxfA9ii71HFqfeb57vTWk2UyopnZJSaaOGiNsiv4muq7LzXrPFkjg/Fr
        n9NMvrNjSArWou3k66JNxgUfA4H6Zy0HrWbtLXFEFVKMSbr/xebAHRH/N4r+RljZ
        /zF2yDxFJSezH3xJVOVbb50FZJp3k7676DSxsLhdZ1DKkqTQ163nLfuV1iy/9UFu
        qowBfto+MZu762T/MZdg3JrSO3Yg8o24agyKhNjihedMlxWZrrVZVHCKUUDYwwy3
        iHUQdilGOIpJvoAjLM90qQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3u5jcj25vy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 11:24:46 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 17:24:44 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.39 via Frontend Transport; Mon, 6 Nov 2023 17:24:44 +0000
Received: from [198.61.64.48] (EDIN4L06LR3.ad.cirrus.com [198.61.64.48])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 0570311AA;
        Mon,  6 Nov 2023 17:24:43 +0000 (UTC)
Message-ID: <7b04a35d-1442-40f1-096b-7908944c1114@opensource.cirrus.com>
Date:   Mon, 6 Nov 2023 17:24:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] kunit: test: Avoid cast warning in when adding kfree() as
 an action
To:     <brendan.higgins@linux.dev>, <davidgow@google.com>,
        <rmoar@google.com>
CC:     <linux-kselftest@vger.kernel.org>, <kunit-dev@googlegroups.com>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "kernel test robot" <lkp@intel.com>
References: <20231106172305.2857-1-rf@opensource.cirrus.com>
Content-Language: en-US
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20231106172305.2857-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fXv8kERJ-MaBjBk4fBMR1xyFMOiQB2O4
X-Proofpoint-ORIG-GUID: fXv8kERJ-MaBjBk4fBMR1xyFMOiQB2O4
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/11/23 17:23, Richard Fitzgerald wrote:
> In kunit_log_test() pass the kfree_wrapper() function to kunit_add_action()
> instead of directly passing kfree().

Aargh! Sorry, noticed spurious word in commit title. Will send a V2.
