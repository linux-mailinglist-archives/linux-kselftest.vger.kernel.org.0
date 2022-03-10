Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910154D4D4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Mar 2022 16:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiCJPeY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Mar 2022 10:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiCJPeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Mar 2022 10:34:22 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60058.outbound.protection.outlook.com [40.107.6.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7E3158D99
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Mar 2022 07:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnmywYUFkwjbD3vA08rZd2S/fvFT/on3OwuXcm98LlI=;
 b=euUvxkXbkFrhT1ygTQtjrQOlxFiutuOQuitDRZNoL+QGiXNVL9rnSH9bxIHD3KGJEnfYjF7zkRk/0HZHYxxYfFg7YVK1xDpuSx2OxDOTX7WK69vtd0rxh2y6Tdt4DgpunKQO22JUJ2bieeI3+BJyYvObJGGZ6uTJehL4Fa4Fx9c=
Received: from AS8P189CA0027.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::28)
 by VI1PR0802MB2462.eurprd08.prod.outlook.com (2603:10a6:800:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 15:33:18 +0000
Received: from AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::6) by AS8P189CA0027.outlook.office365.com
 (2603:10a6:20b:31f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.20 via Frontend
 Transport; Thu, 10 Mar 2022 15:33:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT005.mail.protection.outlook.com (10.152.16.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 15:33:18 +0000
Received: ("Tessian outbound 826a6d8e58c3:v113"); Thu, 10 Mar 2022 15:33:18 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 659e736d93d52af5
X-CR-MTA-TID: 64aa7808
Received: from 09b04bbe7c53.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8BC86A63-E51B-4A35-8E5F-824B4725B5ED.1;
        Thu, 10 Mar 2022 15:33:11 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 09b04bbe7c53.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 10 Mar 2022 15:33:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XxVjo8+5AcLiyeK5LiDNOShqCIzsDcDFAsJCy+HWygcOu0NNQNZ3n6B7ubGsXWo3FQhgmiqZ7lXUy6GSGKXZ8o/H1kjLX5GOahvkIEfAKxXNF6UlI2cLui1/CwPiXb8oNA9FXaeCySSucVfWeDaBjAkrDfu0nkBmKoGt8FLbXmXL7KQPItaHlyj8bvb2oFs7Gtk4Q4CwG9mcQPmUVwrC2hHqoV1LHjWpUMnJ401gI+QvcFYiZbd5qk3UEeBWuiKhOqlokJsyBMdPR9fsPbGKjQ59Tk9wcFe/6mLPGmuHK7ZY/RklFC1gMXcVQJ4QEdaRZTux1Ex7ZEA7wQffmhp45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnmywYUFkwjbD3vA08rZd2S/fvFT/on3OwuXcm98LlI=;
 b=jYa00SalgiFx2JMRTDlH/6ComoOfnfcoZsHIBpp54644iIiw6Ri41EE9pzR6QcoLBaCyLiZFHn60oOvGGutkrb/gMVCm0oVIi58C8/ta0bHWuAUJqLHyh89W20xqpDltWw/7gsVXR5ypyyR47pg9DgavdNXksV3qnRcfquNI9r3Snjsoj5jleiAXA04Jaby76ePVIV5CT7DYIM8DnWpQPauK4Admk21JcwdpwbTMbwxvZOr+vpenqf5nqqnOolIQd0aGSSm8BOwDsf0h3o9FeOzJ1Hp2DFfEqWCFoXxRSytSs9O5LoXpAZJ5UXBIQUQ0Escz7DyH8BRxywbzCZUw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnmywYUFkwjbD3vA08rZd2S/fvFT/on3OwuXcm98LlI=;
 b=euUvxkXbkFrhT1ygTQtjrQOlxFiutuOQuitDRZNoL+QGiXNVL9rnSH9bxIHD3KGJEnfYjF7zkRk/0HZHYxxYfFg7YVK1xDpuSx2OxDOTX7WK69vtd0rxh2y6Tdt4DgpunKQO22JUJ2bieeI3+BJyYvObJGGZ6uTJehL4Fa4Fx9c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com (2603:10a6:10:118::13)
 by PR3PR08MB5657.eurprd08.prod.outlook.com (2603:10a6:102:87::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 15:33:09 +0000
Received: from DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::d858:8573:f6d3:acdb]) by DB8PR08MB5433.eurprd08.prod.outlook.com
 ([fe80::d858:8573:f6d3:acdb%4]) with mapi id 15.20.5061.022; Thu, 10 Mar 2022
 15:33:09 +0000
Date:   Thu, 10 Mar 2022 15:33:06 +0000
From:   Joey Gouly <joey.gouly@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH v1 4/4] kselftest/arm64: Add simple test for MTE prctl
Message-ID: <20220310153306.GA53610@e124191.cambridge.arm.com>
References: <20220310144335.2097457-1-broonie@kernel.org>
 <20220310144335.2097457-5-broonie@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310144335.2097457-5-broonie@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: LNXP265CA0041.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::29) To DB8PR08MB5433.eurprd08.prod.outlook.com
 (2603:10a6:10:118::13)
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 51d13560-ac68-4f5b-d2c8-08da02ab4d1a
X-MS-TrafficTypeDiagnostic: PR3PR08MB5657:EE_|AM5EUR03FT005:EE_|VI1PR0802MB2462:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2462369F4BAE5DF307419CE4940B9@VI1PR0802MB2462.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: ATBkPehJJWSpPdySQzUMuE0nyExSIk5ApKfgaX70x8PRWPEkgahr3nGfoSAIjqMxd/2sR5Cu2sQq9rI9M+6KmhTxX95XHywRE08sCpq/rmObk0kvvY6ons/pWV1EWhM4NcXtBmBaO3R/400+lwSdrC9shQF1XlVMEF47qXri0ECsLtU2z0arjFIga3Rm9fYQ4K4HyUMRZePchE/rOsjM3QCqfiRTu5x4e9VuZaGohZHOfEqVVjNEoMP0w4GC6OGljs5YRMSd6gcRSj2284KaO/DwE0BHaTVjwKwgnezO2ZPYEBXZDKdbzV7EZEKRgt0mc3ayWGAqhhKQi83dwQKTJ70/LolXJzvazlipu63UV+IfYQnjENrfudoGZGrQUnmFBJ+OQ58sDVe0LAQhIsZ3s9rJYEkmmYQcgwUDk/45Ex09s7iNZt06nC7YIGQfydiJm3sn+mL/pc3d2v90/59SJ23P3+Qgy9JADgWjZK79y1FvML7sJQPXSwXgtVwXUYAVwLXHzbuzAzL14IFuYRY/QkeZZDpgIZmFPo0jTzW+ANANSfjRs7ezsJYbVjxjRaP1PHZLNrQ6anRj4GPXpxZBTcCKkFircuOiCA+0vIqfQYAm8p1LGBRmc2IK/8/m8DEuz8LgIO02EDsXpsyuEdZZiZhvDlX8DUYB0s+E+Lwq32MdWDS3mPoKLRrpgt6TCUqqcytI62LegWn+eMN2d4QLnmLWMECoqt6ld0PQ0WNafsI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR08MB5433.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6916009)(54906003)(86362001)(52116002)(33656002)(6486002)(2906002)(6666004)(1076003)(6512007)(26005)(186003)(508600001)(66476007)(316002)(4326008)(8676002)(66556008)(83380400001)(66946007)(44832011)(5660300002)(38100700002)(38350700002)(8936002)(17423001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5657
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: b6c6bc9d-4a94-4eea-2e14-08da02ab47a8
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDzWWONKvQSovjiaz90x7bTTDWAM2NFNQimMkXu5hLgSk4H8VRPMCZNzX7nqPrXndofcm5UzX7jhBAnSL1vRPKiLh9XRW++QUhjV5Tb3nmVocLgxbsRcZXSyhgkdZiC2v5ScUQIufpfjpqMAwI8zUiFnQ35NiYZuvlT+CjRaVnzsT/dLlf9AqCMAydRg6M7N5JWrdcPP9TvgxhNtAgI+nhIMNGbldKd5sA8zgDOWVvagpFa5S5aER8CH47miQWBg/f4/L/1xsS3GbrMxjXS5fkyuS5DbdKNS1zBnGwM4E0tDNhga9ohJtCh/hTh9DJsKmLzSnkMFy9LRrgp+8SaGq6c57rEYAVf3lWbPsyw14oN9acSQG4ekTFgqQXbZt4z62b1Viib1CqemLe2m6bYfzmYGDb9pC+eJTbN6Ule2dS6bRejDz+qPE5Ij5/sqGTHv6efyVYkvluPGYWhxXlGBm+ePnNehR85HoG9gd2fGxMR8xvd6IwY46oXytqKGpwFS6vfbiE5i6zCMnncUG0rlOhPRSv+1vKjV/VNvtIC+feezIQF0qaDByQF/OnsgGdk4w1QYwl6fLFJbSIEt2fvHsZDp7Gbq22lo1fktcc/zykHlmS1Pw8Gpf/KIfQCTRU8oinP0MnODQ+wZ4f4KkZWtFvgc2KKMV/dEh0UKeRbcDh+x0S515WavLgQTBaizbybEDT+9YjEKQlx0O0Pw3i2rdg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(54906003)(82310400004)(40460700003)(83380400001)(1076003)(508600001)(33656002)(5660300002)(44832011)(6506007)(356005)(81166007)(2906002)(6666004)(70586007)(36860700001)(47076005)(186003)(6486002)(26005)(316002)(336012)(6512007)(6862004)(4326008)(8936002)(8676002)(86362001)(70206006)(17423001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 15:33:18.1988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d13560-ac68-4f5b-d2c8-08da02ab4d1a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT005.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2462
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Mark,

On Thu, Mar 10, 2022 at 02:43:35PM +0000, Mark Brown wrote:
> The current tests use the prctls for various things but there's no
> coverage of the edges of the interface so add some basics. This isn't
> hugely useful as it is (it originally had some coverage for the
> combinations with asymmetric mode but we removed the prctl() for that)
> but it might be a helpful starting point for future work, for example
> covering error handling.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

[..]

> diff --git a/tools/testing/selftests/arm64/mte/check_prctl.c b/tools/testing/selftests/arm64/mte/check_prctl.c
> new file mode 100644
> index 000000000000..500aefc5d7cd
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/mte/check_prctl.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2022 ARM Limited
> +
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +#include <sys/auxv.h>
> +#include <sys/prctl.h>
> +
> +#include <asm/hwcap.h>
> +
> +#include "kselftest.h"
> +
> +static bool system_has_mte;

This looks unused (apart from being set in main()).

Thanks,
Joey
