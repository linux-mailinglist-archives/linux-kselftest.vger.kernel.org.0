Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D7742D695
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Oct 2021 11:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhJNJ7b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Oct 2021 05:59:31 -0400
Received: from mail-eopbgr00078.outbound.protection.outlook.com ([40.107.0.78]:16124
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230142AbhJNJ73 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Oct 2021 05:59:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61v0bs/esb+r81WjV/RsmGaj96eeFal+BgtgJoOsooI=;
 b=lM7kv32nhSB+UUOBIqdmjdxCsSuo9V3/3UMwEbNPCZVM3FLAuY4tPKl0YC/mJ/T908AFq9ibPW55em/VazE+Lmo7TLf9TCeosP4QVe3IuBIJO2oc3TJ9os2Ewk8NHHmRcYd75FD2M3CEtM4n8CW+QkeZVh89abJsbJvrf7toeg4=
Received: from AS9PR06CA0212.eurprd06.prod.outlook.com (2603:10a6:20b:45e::33)
 by AM6PR08MB3397.eurprd08.prod.outlook.com (2603:10a6:20b:43::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Thu, 14 Oct
 2021 09:57:16 +0000
Received: from VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:45e:cafe::1f) by AS9PR06CA0212.outlook.office365.com
 (2603:10a6:20b:45e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend
 Transport; Thu, 14 Oct 2021 09:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 63.35.35.123) smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature
 was verified) header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=temperror
 action=none header.from=arm.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of arm.com: DNS Timeout)
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT019.mail.protection.outlook.com (10.152.18.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.15 via Frontend Transport; Thu, 14 Oct 2021 09:57:15 +0000
Received: ("Tessian outbound 16951d3c485e:v103"); Thu, 14 Oct 2021 09:57:14 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2955d868f7ff1b71
X-CR-MTA-TID: 64aa7808
Received: from 8e46e4544c49.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7120FB41-9450-4222-9FBA-242E5314874F.1;
        Thu, 14 Oct 2021 09:57:08 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8e46e4544c49.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 14 Oct 2021 09:57:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jd4ZKQDYkZ51DUhsH23Ga2Png9MgM4Tp86BHQ5DhmyFudhUP2RkWXctDkOlfEAgaBqnmrzzqQnUcEy5GmUE6H3V1D83Jwoqvhj2gQjaIn4hHs03wExMGbwHtGcnVX4HFn6bTy+aYMPcgevX/HxDDbl4a8UmCriMXIvxDTyHtP0++j77YpIvcHsbkcghH3INkC1KNypyxk0QyfcbGM4iI90zgEZoG4TJt5mRxyQ8BSgVs7VwOHplGp8CUEYHFvMRCu0kG8y+u/cM0LPnczsTXCrEcHUxyzPcgMWd4joypr/IVGqyiyGMr5PCcdmQHZG+ZoPcWQMHH1UDncUlBITsYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61v0bs/esb+r81WjV/RsmGaj96eeFal+BgtgJoOsooI=;
 b=mvoM0xhtpSl0SugK/pwxnv+ycvjcUIt6KjogPq39CoZdxnvGwbAHqJxkNturq2d/Wk6nB7LWKZj/53z5aGaxfBi2wYqQoDGZ8yge1wXmoAUNkLb7iwZ9K2nZqYe1D/fqoHTY9XpVpOjnXOH5bG36FJyzOjsMZN5pbm/Qus8CWrJzdq1XFFLmTyDWf+7Y6cLcEKfY9cUnEGFqJGljVnmtcViZGJdX3UgTrTj9gvNunr8jfMBjn1ChVkVpbuT+pVEOixZ6yAycGJrkqHv2CYhxrsWMndPi0gQViV4QxQEOVUEtQ9Gpl7dMXhHqdzvWVrBQXVodHt0zbaW0khGkNWAYKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61v0bs/esb+r81WjV/RsmGaj96eeFal+BgtgJoOsooI=;
 b=lM7kv32nhSB+UUOBIqdmjdxCsSuo9V3/3UMwEbNPCZVM3FLAuY4tPKl0YC/mJ/T908AFq9ibPW55em/VazE+Lmo7TLf9TCeosP4QVe3IuBIJO2oc3TJ9os2Ewk8NHHmRcYd75FD2M3CEtM4n8CW+QkeZVh89abJsbJvrf7toeg4=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU2PR08MB7239.eurprd08.prod.outlook.com (2603:10a6:10:2d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 09:57:06 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846%6]) with mapi id 15.20.4608.016; Thu, 14 Oct 2021
 09:57:06 +0000
Date:   Thu, 14 Oct 2021 10:57:03 +0100
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org,
        Richard Sandiford <Richard.Sandiford@arm.com>
Subject: Re: [PATCH v1 12/38] arm64/sme: Provide ABI documentation for SME
Message-ID: <20211014095703.GB1982710@arm.com>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <20211011131730.GL2700@arm.com>
 <YWQ67ad5wfRgp9l7@sirena.org.uk>
 <20211011141937.GM2700@arm.com>
 <YWSaHaJOIbEigw4w@sirena.org.uk>
 <20211012082321.GN2700@arm.com>
 <YWcnan0ifmngWzJ1@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWcnan0ifmngWzJ1@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::17) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.52) by LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:196::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Thu, 14 Oct 2021 09:57:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a6d8ea8-756c-4596-73f9-08d98ef90061
X-MS-TrafficTypeDiagnostic: DU2PR08MB7239:|AM6PR08MB3397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB33970E7641A22421F845A299EDB89@AM6PR08MB3397.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: oxQnnE76g31qGI8w2hwtoO4eTvB5US0RPzjeXGyT1dlL6RaK2p40T6m8vi85Ra6lD5qZObC/907EL1gZKfZ3Djl0sgrLudDx8ZOuV5onuES0DaS1vNKBlIkXhg/7FvuE7GabyThJdjGCswV4IG8OdBZDtLeDdAT1uHot6USWzs4Olep93/Go5+8QwJdn9gNqz8tdN+cfOFzSmJGVJn2PlcB48pw5H7CQ7KX9C3TFout+LZnaEYH0zb+LIyWYZ3wqIECFXnW0kIkGY3h8oC3MbjkNWa5atQLicSzbgZd5++FGY/O5A4LKQuVOMPI22vyKBOKp5TKxPfRKqkzKD4KWdTLWxb0KrjTqrCvCvrX2ZIAYg74NFTpk8kgOHZ9z8SddHwzWHcaGZoW/lYpr4zVlX1vL5qY/DhpMxaXwdVcEe8fvnbJCkUrXDXDTq5ByCa93vmEFq8odoZWgBHOPsmH/sH37uoSJZUMzOewdnv/JXbXBSBMH8PjKdyLzxr3oxw/ev/y5ehmyfZ80l4HuqxlUlwU6rw84Byxa+ZvJCq/z4MRJIkCyDY7gEFrVfHm7JHgQy2uY9J2JaQBa1OI1Q4ygFD1zpWOg+ef79UmCKvv/BGccdPlV898mX7tJXgRV5Dt4qmWknH7CWzdIb40Dbqw9aoQJ/47F/l8TfhT1/Kaz4u0oMS5f0ZPAJhU2Cpx3zpziFnD5lyKqdqCmigwfIoVObA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8676002)(956004)(1076003)(54906003)(2616005)(44832011)(6916009)(7696005)(26005)(2906002)(86362001)(316002)(508600001)(52116002)(8886007)(8936002)(33656002)(66556008)(38350700002)(186003)(38100700002)(36756003)(66476007)(55016002)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB7239
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 6a02a81e-f2c5-4ac2-3ec2-08d98ef8fa9c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0I/FEwkqbcvmfa4GOnx41rc8ERrD79RHq3yUbiqvViw+Qk1DmP5ab7cb7Ykr7ZCTWXV2Av0LoFiWglMNxklTDszqqRaEJ/D7Fq2puucfYsnEFvfMCu43PuLUxV2v342gX7EmTEiFoy0QtZpEGETBsw2z5OKibkhlTaaqwcFRqAsEBlmwcyyQL64xzhzKHwxA6sftlF33/89UQaoZupgNPIBYhaUjtRXxi14HpTki0M6cE8lNqmlRiZZk3/eXI8iS94sTRg8oGUMMLk/F4z97HNwraiLPurnyaYxsdlyvtv8rg67Phsk8iYu2FLmIFat9YC0nHYp+fwk7w1cNc+t97KMr6MUOnEKepYK2BTqAW1x+iOemSqg1i4AhNMYTRp0ir96WSPae98choyskZrdKUgafO6dUucOuMHGV0Pnd16tB08QiYRJ6cHjfLoeOTc8zuYUPLtIYFmwWo+jm3cyRjxPs6yRGIKgOAUS0Izbl1+ignR1kKg/SShibGwJdQdK3/MJAet6Ir3ijguexdb64WAnZgJW5CS6aVd1J3VuZabjFn7pkOWXWmgbl8L7RWj7IloClwaxyWuXvhuIsG0UTxu01i0l9WWoQTPMz7arnQ8NgLadjvVilzcg1Kp3LLXU83Fn8g9ou4T36GEJ6c74oKXw0fMhaTBMBUqCe3FsYp/WUS0CKfVtbu+5xVyr8sPWRhcJO/SBqo0z5kX1y3tOdUQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(186003)(47076005)(81166007)(508600001)(36860700001)(55016002)(316002)(26005)(356005)(4326008)(2906002)(33656002)(8936002)(7696005)(82310400003)(70586007)(8676002)(54906003)(336012)(70206006)(2616005)(8886007)(63350400001)(6862004)(5660300002)(956004)(86362001)(44832011)(1076003)(63370400001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 09:57:15.2923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6d8ea8-756c-4596-73f9-08d98ef90061
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT019.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3397
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 10/13/2021 19:37, Mark Brown wrote:
> On Tue, Oct 12, 2021 at 09:23:21AM +0100, Szabolcs Nagy wrote:
> > The 10/11/2021 21:10, Mark Brown wrote:
> 
> > > OK, that makes sense.  I've changed the code and the kselftest so that
> > > TPIDR2 is preserved on thread creation.
> 
> > does thread creation have to work the same way as fork?
> 
> > (in a pthread_create child we want tpidr2 to be 0,
> > since it represents thread specific data. in a fork
> > child we want to preserve tpidr2 to mirror the
> > state of the parent as much as possible)
> 
> ...
> 
> > i'm not sure when to do tpidr2=0 exactly, but something
> > like CLONE_SETTLS is set or child runs on a new stack
> > would work for me. if that's too ugly then preserving
> > tpidr2 in the child is fine.
> 
> Resetting it on CLONE_SETTLS is straightforward to implement so if that
> works for you it sounds good to me, I've got it implemented locally
> already with a test case.

thanks, i think that makes sense and works for thread implementations.
