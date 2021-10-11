Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7744291A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Oct 2021 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237323AbhJKOWw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Oct 2021 10:22:52 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:42376
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241867AbhJKOVu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Oct 2021 10:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BJPUtDi0FWyCA5rzQbxT/wcfuXLcIOws8/U2l6YbLg=;
 b=Jlc+7B8zkFOnp9zPo3NTBOLS+7fG2iE/3ERP6HqW4+Ho8UqS6kCsuA9OiEhUr6zzolvqAiLMPT/ZgjDCzWTG/MIYVnPWwNgRr9B2CWQWxtflX6EWYd0S8aHjIxSMlM3MZOTYqfwkSvglJbsj2lY1NKDowuIvTQeyXgKUZYKEl40=
Received: from AM6P194CA0102.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::43)
 by AM0PR08MB3073.eurprd08.prod.outlook.com (2603:10a6:208:65::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20; Mon, 11 Oct
 2021 14:19:49 +0000
Received: from VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::f4) by AM6P194CA0102.outlook.office365.com
 (2603:10a6:209:8f::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.21 via Frontend
 Transport; Mon, 11 Oct 2021 14:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT055.mail.protection.outlook.com (10.152.19.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.18 via Frontend Transport; Mon, 11 Oct 2021 14:19:48 +0000
Received: ("Tessian outbound e27daf245730:v103"); Mon, 11 Oct 2021 14:19:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 81ebd423792ca182
X-CR-MTA-TID: 64aa7808
Received: from 513affa1704a.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A7E97683-CD40-41DB-8308-290C8EE23B24.1;
        Mon, 11 Oct 2021 14:19:42 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 513affa1704a.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 11 Oct 2021 14:19:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGqiZrgwjZacxy/dbgR9SJcHEepCzHf+lQM/KRhnSZEa7J9Ly5DNkRNycW3U9uo/AMdZOrg4q3GIY3kVRgc5zymrrwc0zli9A7z31Qs2dZMAhnyC3EJIX2/gsLlci6vkGGXF75Jg2CQIs2PL6WhwY3AqPtT+Yi4RBIRgbf8RT9gNRDpYwzmJVQRIE1co7GA51LXhsRTU4p/LpS46vqoUmnlTAzyZHJYigiB2a0m3Lyy0FdodDoASpyK7R3TLRExT8M6YTD61EkwE+oZGTjpLn4Vvt1u2zII9V4uM9UHn8r7QTJMW/1GnwVXOiGWN+aupAk6MD5wOBzGM3tnoscM+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+BJPUtDi0FWyCA5rzQbxT/wcfuXLcIOws8/U2l6YbLg=;
 b=C6ctEtrWvzylm3FL6jjQ/TBAgp+IwDFyegdhEmR2ewaD4IyBDmR9SmTynj1MGXeQ3zbQyXqMITFsmHdI02qsYW4DbcSn/UjQpHWsCJYYTfOEar3KvAfOkCGid8b3blRen1dfhidRCtUoPXO1qnCPj6+TlzSGcmjyiw2MKZN7x1f0IGJ4GB8Tozzv4y+s4TYaPYbj2+nbbgdd1RQE8Aydc6/YKEy0yUM7MwUWZy5OenY3dLwHbpkSkTQbtKtihrX7rSGrPjQxc9xZU/vemfj2qdU2XH+L8WbKsJRsKb6qYvTAIgKGWzZlIUfOLQV45nL4eCH/qPmvl4Ad+TRH8clK9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+BJPUtDi0FWyCA5rzQbxT/wcfuXLcIOws8/U2l6YbLg=;
 b=Jlc+7B8zkFOnp9zPo3NTBOLS+7fG2iE/3ERP6HqW4+Ho8UqS6kCsuA9OiEhUr6zzolvqAiLMPT/ZgjDCzWTG/MIYVnPWwNgRr9B2CWQWxtflX6EWYd0S8aHjIxSMlM3MZOTYqfwkSvglJbsj2lY1NKDowuIvTQeyXgKUZYKEl40=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com (2603:10a6:10:2cc::19)
 by DB9PR08MB7131.eurprd08.prod.outlook.com (2603:10a6:10:2c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Mon, 11 Oct
 2021 14:19:39 +0000
Received: from DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846]) by DB9PR08MB7179.eurprd08.prod.outlook.com
 ([fe80::2900:7140:8ac4:6846%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 14:19:39 +0000
Date:   Mon, 11 Oct 2021 15:19:37 +0100
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
Message-ID: <20211011141937.GM2700@arm.com>
References: <20210930181144.10029-1-broonie@kernel.org>
 <20210930181144.10029-13-broonie@kernel.org>
 <20211011131730.GL2700@arm.com>
 <YWQ67ad5wfRgp9l7@sirena.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWQ67ad5wfRgp9l7@sirena.org.uk>
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To DB9PR08MB7179.eurprd08.prod.outlook.com
 (2603:10a6:10:2cc::19)
MIME-Version: 1.0
Received: from arm.com (217.140.106.52) by LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:194::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 14:19:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 697bd152-9373-4aca-70c5-08d98cc22ed5
X-MS-TrafficTypeDiagnostic: DB9PR08MB7131:|AM0PR08MB3073:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3073E341CA47CF3B11BF8555EDB59@AM0PR08MB3073.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: FWykQntRsccG5xZK955QSDDLxDEsh5m8GjatrCBFLsJDcCqUnAMzXkHi9vSTiXvNA0rWeEjUxBZMSJQkukLANavuKgIx5wZJhcRkArGI6chRHtTOhlPMNTWrjDRo0iw4U/oLLlLs0IvTcnCxNjJKiOhb/xJz0ZxHUXIanln2GjYpG870pdCqsdy1mBhNOUtxro5DVy3FbzEa/eJ+ipJuZlQJq1BKNlRVvHUeX+y5fXZB5MMSH4Z8sFy9byQtPFD2ICZ0A1D8IOniklgO0Y9iUwflcL8D13GCgLFTZUzho4juh4Edna9XaU5U5VYI9KpVBE5RPV2pLowAyo0X0qeZ+ynD1thif5OuTOuixHHDWv5noeZjzaEhDkqkBmmKK3YTwx4lD4vcDvLcEqiCSfWFmgk4Wu2qTupE1AjRFwYF5WPwrROqKjbIaZFakUbD4D6fPjGoCvflpKoyVhrrATO8JltnXL39Z65BlGD6GY7vHyZ0oEWLkAuyIh4t5jKGAO/IgxnAkzVi7a+TH7AcvbPvngiO7DVvYGiOx+MMxKshMyd7DXIhXNnxR2bQ/sidAFaOk/QsmNQqDB4uSVYTlHi1uXRF6MRvMcvGKQyv5CkxlICAwSNXXpc/kXt49dFdf1ZmhCQmIGuynKuEQxS7LsktpLm6L//W8/Lcfk9DVHz4Y2Da5TF/MWcU8bYS1B0oagPMbHkuh/hjy1mmBIFSIvzQag==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR08MB7179.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(956004)(55016002)(66476007)(4744005)(66946007)(44832011)(8936002)(86362001)(1076003)(66556008)(316002)(8676002)(5660300002)(186003)(54906003)(26005)(4326008)(52116002)(33656002)(7696005)(6916009)(38100700002)(38350700002)(508600001)(36756003)(8886007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7131
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 88bfdee9-29bb-44fa-5eed-08d98cc22927
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cxdp+1WM+6TEufQ5V4RE+ZkiE65bnzNFd2mGE9Pmx3JyHompbv2XsU0UgAgLTwzyH1vZ9QImSlkLr0fyFjmyEIiPOZwY5qViLtwinXpiMyQA8T8Gct51S5oWjuVRb2dgRgaaQOj4WaxxaieZRpbKY+ZcamLZ4IPJwk/nhMLPX41vw3+ZXHceQaKJLcISIB4QBgpzobBxvHpzc3RFC+fQuJ5Mmbes0dh9mxvYIX/gX+5vcQNojQwfVV2fbrScwSxHElMXlOuNkPBFiWAAOQa79oKNCj6PPHKaawPTMMWS15uihfN0l0s14VRcso9db9l2ldLifjTLxposii49MbeCjKDLRS9Z9N4/UTA6IfSonZuxjKgGVEBuwlFcX6ISND7OuUj9ytrp5srTDZ4BpWnhm1H2vWHx0i+Hp4Zu9bqIXQlzA7tJbT5g4HF4eyQrknF/ZUA9e4fFC2XM2Qnr86MC/NO0FN6jBes7GQWNJbgMFIVV3gG0JmBpqrM+8hfpL4iHholreCA6pVXgrdWEgcKEAf+Fzjt+ufofbJAKEFiRyNGsZiCxaL5KRcUmLndiT/anshrHl0hXMEsrQk1CUOrx2ho4Vy0BTZbEHAZs8v8ukCqTxm0maRU1zmm6FDSA/LJqvxP+MHZBEbw7csYPR8y6dLPK9t8mXn6l+7u9A52mT/guYFn93yMYlNv2Tmp8Nm+qsdcLJCzgn7tzaGAKEs3WZA==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(55016002)(316002)(7696005)(8676002)(186003)(81166007)(36756003)(356005)(6862004)(2906002)(8936002)(36860700001)(47076005)(2616005)(86362001)(70586007)(33656002)(5660300002)(26005)(1076003)(4744005)(336012)(8886007)(956004)(70206006)(54906003)(4326008)(44832011)(508600001)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 14:19:48.5846
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 697bd152-9373-4aca-70c5-08d98cc22ed5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT055.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3073
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The 10/11/2021 14:23, Mark Brown wrote:
> On Mon, Oct 11, 2021 at 02:17:30PM +0100, Szabolcs Nagy wrote:
> 
> > > +* PSTATE.SM and PSTATE.ZA, the streaming mode vector length and the ZA
> > > +  register state are tracked per thread.
> 
> > can you add a note that there is a new TPIDR2_EL0
> > per thread and on thread creation it's 0 (and i
> > guess unchanged on fork).
> 
> Sure.  It's actually reset to 0 on fork() - would that be a problem?

yes, i think fork should not change it. (just like the
normal thread pointer is unchanged in the child process)

tpidr2 is used in the sme pcs by the lazy za save scheme.
(cc += Richard Sandiford, who wrote the specs)

if fork resets tpidr2 then returning to a stack frame
that set tpidr2 could cause clobbered za state.
(userspace can fix this up, but if we want this case
to work then it's better to fix it on the kernel side)

