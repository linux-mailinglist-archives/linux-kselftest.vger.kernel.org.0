Return-Path: <linux-kselftest+bounces-378-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363057F2D06
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 13:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845E0B2154D
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Nov 2023 12:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2864A996;
	Tue, 21 Nov 2023 12:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FFDmN1wP";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="FFDmN1wP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2078.outbound.protection.outlook.com [40.107.8.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ACB192;
	Tue, 21 Nov 2023 04:22:12 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=iN6VzdFWLFlyAd9kcu9KUWDEr72z2c+3zpUSjV6gOOZHOSsvHoxPGx1CfW9Fc9AE5H4xxjyOxs6LiqGae73qeQjK7Pa4DoNbg0Apm1JyDYUXEAdE5KkWBsUs5HUD4RToYZ741tN4mQfXXAPcIpdUslhmy/hrR5XlUdIJ2d2D0vdZMriljttrdoYqEKkFHT5rPmGEHXggB0U5F8NGpM7AsioT/2StxAbBmusuTblc0ljEW3yXXpUiNr9mQBDfr7PLuO+3BfkLTdAoA9RO3cNhkQl8RRoft1XNMyCZztwp4hMmbOKhGrgnJXmYkQhZwoEJHxdSk36XbqhuBieD+oSmsQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTMj0rXGcLMdtxCWMt7OvM7KklUH8bLRxRnQvCHRSnc=;
 b=XcNZ8qrb8f47i/13lIR+pUSbRNXaBJxYtLtIntHnilBqYf2lmL5ZjkKgM5N1h5eKrLZYR9d0qr6+UN2Hl1uJRAFOgrG6yylk+HzTbqQkr5Yt7DfJ5oS1ShVQ4wiDbjOjaFhxIu/+ids3QVg8RXp7kA54d8AFEJEkEt341n3G/WcorCHAiK9nTFKhK1kZsiw7ZZ92FyoDd3ENYSHtpWP/JBv0lPj+rEvzLcw6sR8bYVYGqTJwFawU8OEFvOv5EDVC6BVGn1DeoM+/Y1oaF8ozx0AtzB5HMEnI5QT/y7ayeH9do/ml+h8RJroxA7FiTmhS+PGlPhuXQ+ZMM1+GhZ+Ciw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTMj0rXGcLMdtxCWMt7OvM7KklUH8bLRxRnQvCHRSnc=;
 b=FFDmN1wP3RDbkawtUOdfyJI74301frhKfOVwsaCgusPFIacgaHTAam5rKtUT84ld6IEC+NVWq/0F9aKWj6DypTnIDKuVKGLQYxtFZNztPL0s0Ha1vSyXjxvdE796pmiizNByuXm0Wl7pnv6JoMtmjRqumb2/oe3txj3rgfEmEPY=
Received: from DB9PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::29) by PAWPR08MB9567.eurprd08.prod.outlook.com
 (2603:10a6:102:2f1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 12:22:06 +0000
Received: from DU6PEPF0000A7E3.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::9d) by DB9PR01CA0024.outlook.office365.com
 (2603:10a6:10:1d8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28 via Frontend
 Transport; Tue, 21 Nov 2023 12:22:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000A7E3.mail.protection.outlook.com (10.167.8.41) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.13 via Frontend Transport; Tue, 21 Nov 2023 12:22:04 +0000
Received: ("Tessian outbound 7671e7ddc218:v228"); Tue, 21 Nov 2023 12:22:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0d1f0a828ce12e80
X-CR-MTA-TID: 64aa7808
Received: from f5dd5feb72ff.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id C1AD0790-F811-46EC-9500-F77323CE7DCC.1;
	Tue, 21 Nov 2023 12:21:53 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f5dd5feb72ff.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 21 Nov 2023 12:21:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPSVtAe5SiN8jo58zUbprhvz1OxV1JPIFNgXOBcr+veIoovSL9IuOVxtlCz7dZHolYrPlU9b2uTM14ErdoKI/TNg4UNV4t04Gjzi97+fHnciJr3uu4Qn1OqyXqeAQjQHF7Px3KwsxgMJRki5Zg8mIPMaYJD5DYxXHC/0L8tJNEgcKc7uLe5Q5KNRFsqHn+Lw5l+VVfe6cgtRYP8AhW+hQETEC1lVoNHxTeQODwoa7qSA5B7SSrVyqCUHVnPXKo3eblD10ITwWwQi5X6Y7EgSm5HI811JmD5He2CD9nwOlEA6NmPzJxnkQu4edxWnq7wYK6J1mmNBIxC9S21REd+++A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WTMj0rXGcLMdtxCWMt7OvM7KklUH8bLRxRnQvCHRSnc=;
 b=WvrE+WddSyUBx0sQaQv9UCsqX+hZRqpb+oCxh9CNiPOMoKazW+UtckfvLhWmVPd0l744E4vMfEfk6OjZigt9GJhdFLagdBNO1FzUesoHNZsdTT+xqYPhVUw79R3K3hl4C1gj5Dq4t1TjdbxDr5CeGJxtSLKJ88LUqExaiEFU4pmiVEv8j65b6EToSEyc9O7/FOBHZU+g3sV7kGI4I9Q5yRhJXEFPof+knCgRc27OHRwQw4pw5z2Te89SyX0uOSb1pwGPRIBAEOIaMYZK9L9fW7Z2EixvDdfRV4V/ufXAVvWlCR27M5UjIZwAR7/71ts/WquLTgcFaOleRqL5vkg5ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WTMj0rXGcLMdtxCWMt7OvM7KklUH8bLRxRnQvCHRSnc=;
 b=FFDmN1wP3RDbkawtUOdfyJI74301frhKfOVwsaCgusPFIacgaHTAam5rKtUT84ld6IEC+NVWq/0F9aKWj6DypTnIDKuVKGLQYxtFZNztPL0s0Ha1vSyXjxvdE796pmiizNByuXm0Wl7pnv6JoMtmjRqumb2/oe3txj3rgfEmEPY=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by AS8PR08MB10222.eurprd08.prod.outlook.com (2603:10a6:20b:63c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 12:21:50 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::1fbd:16e1:518f:a381%6]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 12:21:50 +0000
Date: Tue, 21 Nov 2023 12:21:37 +0000
From: Szabolcs Nagy <Szabolcs.Nagy@arm.com>
To: Christian Brauner <brauner@kernel.org>, Mark Brown <broonie@kernel.org>
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
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Kees Cook <keescook@chromium.org>,
	jannh@google.com, linux-kselftest@vger.kernel.org,
	linux-api@vger.kernel.org, David Hildenbrand <david@redhat.com>,
	nd@arm.com
Subject: Re: [PATCH RFT v3 0/5] fork: Support shadow stacks in clone3()
Message-ID: <ZVyg0WgILK35xjBn@arm.com>
References: <20231120-clone3-shadow-stack-v3-0-a7b8ed3e2acc@kernel.org>
 <20231121-urlaub-motivieren-c9d7ee1a6058@brauner>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231121-urlaub-motivieren-c9d7ee1a6058@brauner>
X-ClientProxiedBy: LO2P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::35) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	DB9PR08MB7179:EE_|AS8PR08MB10222:EE_|DU6PEPF0000A7E3:EE_|PAWPR08MB9567:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e14e46d-aba7-40ee-fdaf-08dbea8c78f0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original:
 c6j6DQrCIOlQ5ci9DnEEtGaBxTNSHekZKBNA3PzH98ys/hwLDOpvMoUGoXxh/4e+l5xtwaZGe0sEaVbPqpkRg8LCZmvDsrVgqdKcXdaQMRRWW3/zqK561mmz/2tObnf0w0vAMh7dGOgPVvLiW9E8s44Anc4PKCvjHNS5bZr4T/RDS4peCj5eF6K6na7O747rcSqA4IUTNrboYOKYiYSjUPgtgvX/L5lyXRwOXLiDoGOpSB5GOtM4aRWjqDB07FfEOR2i6HGft09NMPQH1m1zG6z0fvqN8NpZzIcLMyRhoVMeH+Smp48pXpUgCXOIob3cjw+iFQxjrY1PPw4derSnwPFTDAQQgMCd/kOMH4FQ0JrogbI7bVwLN0FPOwiZxxBBPjTFNim6mCcbtMXCAXsKCXo87MWKx+6ZwsR4JA3th+8d86mbnfgSTCU2Wb9KkGuTbcSf0ilQUgGNBVfw1QfA6fFkCnrGHLgqTV4MVNCbusTSQ6yRMBKiF/lVbDYvup8y37QNld0NtXmH4XQy46fO8bVNTqDrpFPVWp7C48wjbg+6le+xNozxWMRg1z5xkmYA
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(316002)(66556008)(110136005)(2616005)(26005)(41300700001)(66476007)(66946007)(478600001)(54906003)(6512007)(6506007)(83380400001)(6486002)(6666004)(8936002)(8676002)(4326008)(66899024)(7416002)(2906002)(5660300002)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB10222
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	e8867878-639a-4bab-e2ae-08dbea8c7082
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	trGM2ALGtA6l5Qzy+wBElvAYneO5HCC0Rwaj7JD4sjNEcs57LD8rmYkuA1nP0iCCWhIoNsIJ+RQsTqMqQdDVhvZlBsQAJYVelTZAmVoMxsquqc0yMbjBWpDNo0g65LucEGGstqQPHikStC/CXKgOaWhTYx+5Rk1T89oKMthXtuuUxxiINhM/CQOPEtNiec32KmmMYeZzQU6j+sGsf5vouPn90SNLRcSxXdC/gsHg8JpVLMf4kt9MP1l4m0FmJDTyEu/fKJ/CVTwtgNlEi5MgqOBAH12kIHwt14NhxFeisqdxVTTvYDxuJVtFeF6tYLoeYdunRZdUszdaV4Y+5+/2q/clGpDVp8R6oHVz5IZt0oQ1qfew34hQndHjdA4c6AOSt0CLsLQH4CWaFmGyMSuxwdZmzh468YjdIU0t7bZwaZVwgQJ6N1L0Y0NTKErAbl41DVo2N8/Esfj9zKDf4xVpuRbMMetqlk4WMqMI/9VcCp9wwmvX20JI2ZBJ8gpJs5ffqR3ogH+RAYDXUICxotZxBExn45BBAMVol0l8NmUlZyunNTP436GysNVGWyyAuGijiMDSfveuGWqhebcJ/BVMDQdQmNeSSeHYAN5gzssS8aTPx3m7HyU5EhsXzJzJy0ihwRjTljfKJ0/pCMk5S1LBL8tjhxqLIx+0X3qMUfUU4aMigOey/+ag8w4zldj3ukKK/lJtwSM8ewD9V6DSUkOhv8oIISkf3XQ8OpiingNuFWO0d6Bp/8c6uANSaYKLY9z9
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(66899024)(70206006)(54906003)(70586007)(110136005)(316002)(36756003)(6506007)(6666004)(6512007)(81166007)(336012)(2616005)(26005)(6486002)(478600001)(82740400003)(356005)(83380400001)(36860700001)(86362001)(47076005)(40480700001)(2906002)(5660300002)(450100002)(41300700001)(8936002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 12:22:04.7187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e14e46d-aba7-40ee-fdaf-08dbea8c78f0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E3.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9567

The 11/21/2023 11:17, Christian Brauner wrote:
> On Mon, Nov 20, 2023 at 11:54:28PM +0000, Mark Brown wrote:
> > The kernel has recently added support for shadow stacks, currently
> > x86 only using their CET feature but both arm64 and RISC-V have
> > equivalent features (GCS and Zicfiss respectively), I am actively
> > working on GCS[1].  With shadow stacks the hardware maintains an
> > additional stack containing only the return addresses for branch
> > instructions which is not generally writeable by userspace and ensures
> > that any returns are to the recorded addresses.  This provides some
> > protection against ROP attacks and making it easier to collect call
> > stacks.  These shadow stacks are allocated in the address space of the
> > userspace process.
> > 
> > Our API for shadow stacks does not currently offer userspace any
> > flexiblity for managing the allocation of shadow stacks for newly
> > created threads, instead the kernel allocates a new shadow stack with
> > the same size as the normal stack whenever a thread is created with the
> > feature enabled.  The stacks allocated in this way are freed by the
> > kernel when the thread exits or shadow stacks are disabled for the
> > thread.  This lack of flexibility and control isn't ideal, in the vast
> > majority of cases the shadow stack will be over allocated and the
> > implicit allocation and deallocation is not consistent with other
> > interfaces.  As far as I can tell the interface is done in this manner
> > mainly because the shadow stack patches were in development since before
> > clone3() was implemented.
> > 
> > Since clone3() is readily extensible let's add support for specifying a
> > shadow stack when creating a new thread or process in a similar manner
> 
> So while I made clone3() readily extensible I don't want it to ever
> devolve into a fancier version of a prctl().
> 
> I would really like to see a strong reason for allowing userspace to
> configure the shadow stack size at this point in time.
> 
> I have a few questions that are probably me just not knowing much about
> shadow stacks so hopefully I'm not asking you write a thesis by
> accident:
> 
> (1) What does it mean for a shadow stack to be over allocated and is
>     over-allocation really that much of a problem out in the wild that
>     we need to give I userspace a knob to control a kernel security
>     feature?

over-allocation: allocating 100M shadow stack (RLIMIT_DATA, RLIMIT_AS)
for a thread that keeps arrays of data on the stack, instead of say 8k,
and thus running into resource limits.

under-allocation: small thread stack with runaway recursion, but large
sigaltstack: the stack overflow handler can run out of space because it
uses the same shadow stack as the thread.

> (2) With what other interfaces is implicit allocation and deallocation
>     not consistent? I don't understand this argument. The kernel creates
>     a shadow stack as a security measure to store return addresses. It
>     seems to me exactly that the kernel should implicitly allocate and
>     deallocate the shadow stack and not have userspace muck around with
>     its size?

the kernel is not supposed to impose stack size policy or a particular
programming model that limits the stack management options nor prevent
the handling of stack overflows.

> (3) Why is it safe for userspace to request the shadow stack size? What
>     if they request a tiny shadow stack size? Should this interface
>     require any privilege?

user can allocate huge or tiny stacks already.

and i think userspace can take control over shadow stack management:
it can disable signals, start a clone child with stack_size == 1 page,
map_shadow_stack and switch to it, enable signals. however this is
complicated, leaks 1 page of kernel allocated shadow stack (+reserved
guard page, i guess userspace could unmap, not sure if that works
currently) and requires additional syscalls.

> (4) Why isn't the @stack_size argument I added for clone3() enough?
>     If it is specified can't the size of the shadow stack derived from it?

shadow stack only contains return addresses so it is proportional
to the number of stack frames, not the stack size and it must
account for sigaltstack too, not just the thread stack.

if you make minimal assumptions about stack usage and ignore the
sigaltstack issue then the worst case shadow stack requirement
is indeed proportional to the stack_size, but this upper bound
can be pessimistic and userspace knows the tradeoffs better.

> 
> And my current main objection is that shadow stacks were just released
> to userspace. There can't be a massive amount of users yet - outside of
> maybe early adopters.

no upstream libc has code to enable shadow stacks at this point
so there are exactly 0 users in the open. (this feature requires
runtime support)

the change is expected to allow wider deployability. (e.g. not
just in glibc)

> 
> The fact that there are other architectures that bring in a similar
> feature makes me even more hesitant. If they have all agreed _and_
> implemented shadow stacks and have unified semantics then we can
> consider exposing control knobs to userspace that aren't implicitly
> architecture specific currently.
> 
> So I don't have anything against the patches per obviously but with the
> wider context.
> 
> Thanks!

