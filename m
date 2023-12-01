Return-Path: <linux-kselftest+bounces-954-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2FC800A1A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 12:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8150C1C20B0A
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 11:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C56E219E0;
	Fri,  1 Dec 2023 11:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tjkNfvjU";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="tjkNfvjU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2077.outbound.protection.outlook.com [40.107.20.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4A1708;
	Fri,  1 Dec 2023 03:51:11 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Gn0mFpZdVY6bQoN2LWGpZ0rZabioEgxqSjUxZpLxV3zpbzL1cQmJ3tKtOUOuFkEvhbtTkdzud8ylya74jyuqZsf4jEdfEWQ00r5fgXn4a0muVYdEb74erzuU5VEUDBbnMFy39ybsTXXFSTXFn/tE8pG0c3tcp+YBpHAozhzOyDFZb/AFy7tyXVkJxoH08F4s49vSBpyTsmKyMRT7HOJdj6wbCxTMo3epm9kmlE1UXHkThcIjyjqVRzDMksiiLINmvVo0ygT7Ousfy0O9YQng+wM0gn1yeoRRXGGz/KFgahdxkXMq3Xu9mimrOMLnAwALH7pD2HnZI2yQ+DcZzRdKjw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOfJnGFRjrhfzNfNzj+fXxO2O6jGi0WI4GLhiNZcRjQ=;
 b=HmzHr6Vmn4CbyrITsK/KfDVg0b+b0bkPI/sZm1IiKXdN26SvEgDkV0zyKmupb0lIvfNF0BH0V/MRxTT9FzD68Zc6ItWTa6YPKrGs6MaYEzOzfmXNkxM8v+9m7MUUkvsJg/Qe8u6eZVeWToZXPeggQoiIqAYlHXJrPqPOHQFlzQ84LIodzH9b7K+yOg34LXW4hbjmARhPoqP4dKGo4rGV9cbOl5KaG8sCG9OkrvZVbJqzxZxKF+m+UylCTUncLdZCyP7HcH7RD4STfIS6HRKQeE7To2cL1faQag60PKfWtMD8/YgkgXAlenMK6AaG1IVvuNnIHVD0TUaMqiqhVGIlgA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOfJnGFRjrhfzNfNzj+fXxO2O6jGi0WI4GLhiNZcRjQ=;
 b=tjkNfvjUgzUXlyiGfDci+ZlGGxaUZgFGbrVic6jGPnZ7bdhDSahcypqaxck+be69CEo83TWd2SXdyMvBFoxZNpLBMX2boYfCNzXLJDu+JejeIZ/Y5TszsSr5ImYs9MaWb7dqaNpolyZHWWsa62RbvFspS0p3oldHJFyuUX4t828=
Received: from AS9PR04CA0156.eurprd04.prod.outlook.com (2603:10a6:20b:48a::28)
 by AS8PR08MB10245.eurprd08.prod.outlook.com (2603:10a6:20b:639::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.27; Fri, 1 Dec
 2023 11:50:54 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:48a:cafe::d6) by AS9PR04CA0156.outlook.office365.com
 (2603:10a6:20b:48a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26 via Frontend
 Transport; Fri, 1 Dec 2023 11:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 11:50:54 +0000
Received: ("Tessian outbound 5d213238733f:v228"); Fri, 01 Dec 2023 11:50:54 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5be073b94b2bd625
X-CR-MTA-TID: 64aa7808
Received: from 761ebe349dae.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 534B65B9-9AC2-489B-874B-44F48B54725E.1;
	Fri, 01 Dec 2023 11:50:44 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 761ebe349dae.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 01 Dec 2023 11:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6tjL2Y2exkYN+BABZ+THO1uprJW+LCTZqvTLGf8n4veUT6Nk5BK7qXcSkcDPZ4LI1NzunZ4cWnLSAKJxsbcCrMlMkif9wdvJurzHue5CT0Az1/1sSxY5NGUOCTGtpjmB0qEJry9xNHMX+EYTHWRQGe/HM9onrIi/pPlpHA35flGB4SGOHWP9OY/d9I0uOa9dYjZMs+l/2iKLMtyQLwwIXGuztAOrqDxqjNdy6CNG9nKW4/whLP4ZPTYiusMC/TgcklAWAx4FjsaXjquBqPCU0OFoMh9bzX6wJEcOw1aXVxcM5Ynb7ZDvBU+WaNsxH6gWFh1ny5WvSB2kOj0VT5Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOfJnGFRjrhfzNfNzj+fXxO2O6jGi0WI4GLhiNZcRjQ=;
 b=lg4XbdHEv/rEp7lHUNHd5MZ+4fCQnZ1lH5qwLO5Px45D/1FhSYtyBsQopWjr13b2TwIULkG1is4LtfR9SnXZTVjFF966JI4I4VjdVh7RaKnvWEsKp6fDkiTk7her9F2aldIj+En9geS7hHLJ9Pc494WmGVsVDixqi878XAa/CVXkewHkTmESIlIx+C1mkpVfnhZ6zKW6kgWVU/9lwXFF5txSNasYSP+UnQZK9wSNL0+VThCiTUNe3kNRbxbwDQYAGIBwUgDbeSCJ3mMCMGrrpLSjyfrw3PH0o/9aIul0P+GuaCLT/PzyFT3t/JRDwXZtI3PKSBzG73IR+3XpTKNjug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOfJnGFRjrhfzNfNzj+fXxO2O6jGi0WI4GLhiNZcRjQ=;
 b=tjkNfvjUgzUXlyiGfDci+ZlGGxaUZgFGbrVic6jGPnZ7bdhDSahcypqaxck+be69CEo83TWd2SXdyMvBFoxZNpLBMX2boYfCNzXLJDu+JejeIZ/Y5TszsSr5ImYs9MaWb7dqaNpolyZHWWsa62RbvFspS0p3oldHJFyuUX4t828=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DU0PR08MB7592.eurprd08.prod.outlook.com (2603:10a6:10:311::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 11:50:41 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::292d:9c0e:e9f7:deba]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::292d:9c0e:e9f7:deba%5]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 11:50:41 +0000
Date: Fri, 1 Dec 2023 11:50:25 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>,
	Florian Weimer <fweimer@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFT v4 0/5] fork: Support shadow stacks in clone3()
Message-ID: <ZWnIgQgUW0Eyfcw9@arm.com>
References: <20231128-clone3-shadow-stack-v4-0-8b28ffe4f676@kernel.org>
 <ZWjb6r0RWPo199pC@arm.com>
 <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fce4c169-5d19-40e8-bc32-0abec9bb008e@sirena.org.uk>
X-ClientProxiedBy: LO2P123CA0086.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::19) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|DU0PR08MB7592:EE_|AM2PEPF0001C70F:EE_|AS8PR08MB10245:EE_
X-MS-Office365-Filtering-Correlation-Id: 71efc5de-c35f-48c5-b488-08dbf263c65e
x-checkrecipientrouted: true
Content-Transfer-Encoding: quoted-printable
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 pKChDl81TawDdNwef7yPDHvKP2nZn90vjEytN0bK8V7NXmQ0V4kzH/dJACQZ/9G61nVRwCW9zZbSZ8a9sc/x7zpIiVGw3H9JrFzbfpBoxsT74s/O5z0Qg0FgGu61lTOdE/cxYTTu2YhBpPNn582iBdEw36VTcldxZ9wyPiN2xtZspO3H6C7ksS2z096jbVxxrA1U2RVGyxoz5mtY2dvhM3pjVfrCwMPLyKVhHn8TeW1o+zyu4pCxkq72OWCBnhFN7yYWFgl+1/FAzeA5KTQmbSQUTXn74I5FlE20pRi1QXmQjrml2jmuP5td9LwhhBhU8TFdTTeQIkBCkwX9iXCZf5bY2ZAkOKjLV1js3QmiihACHv9ZCnnUq2PAhLZEeVxch/UWKzhtVvh2ygKl6bLdDmdLNGpN/Ss5cT2sLA+2hyk8ZXG/JWG1dZX/MUfQKsH/aWGAXiY8GklYcGOwMuH/zT8X9FdZJ8m/NuJCsSto7N2+nGf++cTMNQPl7hLrBze6uk8ros4a6OIdy2rR/QFUznHvETx9KZCnmUspf+6GDdv0CXzOZpBCNpTpfPArpTOK
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(36756003)(6506007)(6512007)(6666004)(2616005)(83380400001)(6636002)(66946007)(66556008)(66476007)(7416002)(54906003)(316002)(110136005)(2906002)(8936002)(8676002)(38100700002)(86362001)(5660300002)(478600001)(4326008)(6486002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7592
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ad2de9a8-26f3-4e8f-665d-08dbf263be2b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1mUxC0/rFYoUDHsnZv5DUINwAxQZajnys1L7T3d2wvogAZNkinCJl4Li9e6bWKGWKBhyJnO7Q7qXHmqn/Sndryzq9144XOP6OivK+u16LGSEka6+40ZRfiSnHNb01aD/g4wZqDZSTKLxNdEKBCkVZshlhGHR19ugqSSA1ch69Ot7nnB6iqjzrI+UyopW6j0wL0ZDBfuBnglUN6mW9/NG2kOjLD46thsLrje+fFGZXq6z4v9CL/c7beKonEnQ5x/HEYK/rWXQ3SPKaDqxBrHjI2nvgT1Ti2a+K8N0BlvScr4yn4Y4LmOEHudGtBs9kQAdvxGtZMiYE7puYRlCVkdthyLY8USWKLgPTxOwNwTXvLEPjtyWOqd43lla/iVMGe9XL5BVvsgSLD/ewTo0+j6GYjXmvpsyD5GHvXrlfBmyMCmLVppIv15P6MeJWpz5S9Z4cTUWWrc3G3EWf73TVcGMBS0hk8Mmr2liZcSFWObtxyQYcXJkRS66Uf0/Om7idPq8ayq4sGLGeW3UkqZdOpNIwh4BqI7ZcIuynp3QcgYnA+DpvDgFgSsU3/tuNXnsRi11HcH7O+m9rKmIf3xo6s935onojCeUPRVHSdcwl+c02lQBkHNtHRP24Kbx8PQjhWVdkr5J9PofCokyLBkecW5/GF8dipCo7pxIRmOiGfhP67WbVDDjBS5Iq5ZQcrLTf9KRDh3SG9TN5+XInMIo9JAEIeEJ4WxEXpirsvkFdZJfizMFIWRVuj6JH6vT+JI/0ObL
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(82310400011)(1800799012)(451199024)(186009)(40470700004)(36840700001)(46966006)(4326008)(2906002)(450100002)(8676002)(8936002)(41300700001)(336012)(26005)(110136005)(316002)(6666004)(54906003)(6636002)(70206006)(70586007)(5660300002)(6512007)(2616005)(107886003)(6506007)(40480700001)(83380400001)(47076005)(36860700001)(6486002)(81166007)(356005)(86362001)(40460700003)(82740400003)(478600001)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 11:50:54.5274
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71efc5de-c35f-48c5-b488-08dbf263c65e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10245

The 11/30/2023 21:51, Mark Brown wrote:
> The concern Rick raised was that allowing user to pick the exact shadow
> stack pointer would allow userspace to corrupt or reuse the stack of an
> existing thread by starting a new thread with the shadow stack pointing
> into the existing shadow stack of that thread.  While in isolation

note that this can be prevented by map_shadow_stack adding
a token that clone3 verifies.

> that's not too much more than what userspace could just do directly
> anyway it might compose with other issues to something more "interesting"
> (eg, I'd be a bit concerned about overlap with pkeys/POE though I've not
> thought through potential uses in detail).
>
> > I'm not against clone3() getting a shadow_stack_size argument but askin=
g
> > some more questions. If we won't pass a pointer as well, is there any
> > advantage in expanding this syscall vs a specific prctl() option? Do we
> > need a different size per thread or do all threads have the same shadow
> > stack size? A new RLIMIT doesn't seem to map well though, it is more
> > like an upper limit rather than a fixed/default size (glibc I think use=
s
> > it for thread stacks but bionic or musl don't AFAIK).
>
> I don't know what the userspace patterns are likely to be here, it's
> possible a single value for each process might be fine but I couldn't
> say that confidently.  I agree that a RLIMIT does seem like a poor fit.

user code can control the thread stack size per thread
and different size per thread happens in practice (even
in the libc e.g. timer_create with SIGEV_THREAD uses
different stack size than the dns resolver helper thread).
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

