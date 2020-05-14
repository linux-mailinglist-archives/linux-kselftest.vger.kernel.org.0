Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00131D27DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 May 2020 08:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725864AbgENGax (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 May 2020 02:30:53 -0400
Received: from mail-db8eur05on2069.outbound.protection.outlook.com ([40.107.20.69]:6095
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgENGaw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 May 2020 02:30:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5EiRaC5NiF2AoozIcvE8XIs01x1LsDgOtZkYAvaGPnlzM/ne9L4HzZfwAv+u6gQZHSCLPUzYOrb9pu/nq4dP+MjnxdmEhEjhbPqVFZA95LnmWzflCw/yj4CS7ZYU3MVJlgO1cclEL9kgEjcL9rLGA9sTmpfcUyUGTCtTiR927iIBXksZPRdlCT71Ofc5/DyNgQMiOQaLzqBntdVrPyb5duoNCLP/e3eA0XZL/iIHM5zvw6KZ2iIxObb3HM4oTYqK3CPPU7/CLgzABu8GtXLh8wkDJ1ZGoDUdVv+EvDuRiytd64VwMlCdCSpZJYTgaOMUBYzLcQi8t2iCroKhiM/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OXWJqG+mUIbLqd9ui1zO+Z8NvX3XeBWzEf34o+cUZU=;
 b=lBT0EIRu19zejAL4qekmSY+kSb7TOmze0mXvtndBFIPxJHPa2Uvck7B/t4UVK49KCyrtfSCNJ+1ChniZ7/RfgwXN08nScfFwBzK9tzfuTeFsu4pW9suC3EfeuBQ+fPTdarvEUPx+HpKjYj+SIBKYK1TNUedAeHEnwUjzghGhfm2+I38mKyGoCHVrBUhUmE5BtLJHpU3QxPAJqrRRCDrXQa6vTq+wuTDrOzoCDZstVciipHkp74obLffMBqiih5GgIkf8JtnNfDSRicm6QqOAsEXMIyrY1omeQYmqWmFX8w/qdqvDIpVdAqGBzEc0M5LnuN5WXrZY8IKbdHR8lV1+Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3OXWJqG+mUIbLqd9ui1zO+Z8NvX3XeBWzEf34o+cUZU=;
 b=NfMIvV6RzkQfFBNAUBRfW1NaTUHFE0k6mM7NXyp4kFRVAH+JF0PP5+aFCUc9Mv2wHuDWbRqQPJ5AOsPua2YxWdy94MM0PWddru8Nhp5SDYW6wo6ZB9nQ6dzv49q0igralzt8v3Q0tQA/mbLcFKspZQ3C/El5Q5jNwcZ/9W19UI0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM7PR05MB6995.eurprd05.prod.outlook.com (2603:10a6:20b:1ad::15)
 by AM7PR05MB6961.eurprd05.prod.outlook.com (2603:10a6:20b:1a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.30; Thu, 14 May
 2020 06:30:49 +0000
Received: from AM7PR05MB6995.eurprd05.prod.outlook.com
 ([fe80::3903:9c1e:52e0:d74e]) by AM7PR05MB6995.eurprd05.prod.outlook.com
 ([fe80::3903:9c1e:52e0:d74e%6]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 06:30:49 +0000
References: <20200513175746.7294-1-vladbu@mellanox.com> <20200513.125709.1574810036252704473.davem@davemloft.net>
User-agent: mu4e 1.2.0; emacs 26.2.90
From:   Vlad Buslov <vladbu@mellanox.com>
To:     David Miller <davem@davemloft.net>
Cc:     vladbu@mellanox.com, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
        dcaratti@redhat.com, marcelo.leitner@gmail.com
Subject: Re: [PATCH net-next] selftests: fix flower parent qdisc
In-reply-to: <20200513.125709.1574810036252704473.davem@davemloft.net>
Date:   Thu, 14 May 2020 09:30:46 +0300
Message-ID: <vbfwo5fxc2x.fsf@mellanox.com>
Content-Type: text/plain
X-ClientProxiedBy: PR0P264CA0170.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1c::14) To AM7PR05MB6995.eurprd05.prod.outlook.com
 (2603:10a6:20b:1ad::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from reg-r-vrt-018-180.mellanox.com (37.142.13.130) by PR0P264CA0170.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1c::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 06:30:48 +0000
X-Originating-IP: [37.142.13.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 139baac0-0c7c-4d42-9c16-08d7f7d057e1
X-MS-TrafficTypeDiagnostic: AM7PR05MB6961:|AM7PR05MB6961:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR05MB6961D1434ACCA915AABEFF09ADBC0@AM7PR05MB6961.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hMqQAKZaiMmZZXuUsDvuJ85UEGKyGTehPXmIjdYJPYkg/fJDxFECkVJ/R5pfHG7U6243MOYWdAcnV9i1prXZWUyvarwu8Wt9Z4nop1y8KWJlhRf8xpbVXulRdpRHRDBIkE9KFxos1JK3y4pZCy4TvKG146+1TWPPqxmUn5PjO+TxhsJ/2Tx98Fx8/w3xsasgjtofa0SXAGyM8aPYBNjX5DMZdAY2aY6kQjcrxuPHv5Xl+YQHyZYQaQcJwt4xViNCayNrSgGpHHNfbzK67uNmMxXOW+v9CMUa/8AjBOjVLLIiW9mGWgQWtf8W7G1GtAc0SI/RF9iSk4SX+aD7CsQ9ZY0LDQCUjnUuY9XI+pWVQPrCsOnLNaaU9axcjnqEGpudU8RuWHIOHLtsTnh+dPw6OKiafwRh0tYAoJKGr1YHMvwKw05JtaC8xHXTywqvw+ny
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6995.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(2906002)(52116002)(8936002)(2616005)(8676002)(66556008)(5660300002)(956004)(66946007)(6486002)(36756003)(7696005)(86362001)(66476007)(186003)(6916009)(478600001)(558084003)(4326008)(16526019)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 3vA5xMup5j7KVnOzlITgeCH0V/CAfU86THVeAtNUwMI0LJUPKD9sJ50ZXJyriuv6/nMOCRjhi3xDdrRFA3IzmBVl1RHDS3T0D6sPrtIm45JmCzy0YY3bJHEt7Wp9CqB2vyftzCFOZginbyyz5LzwkkD6a72UrcOpbmu832/XRYCdJVUMTXgo9z2f92p2KPIG/9pNAnYUnjeqTQDlhvmOQXH7PKquHC3g3w2SNGD2+eJW1eQR2vVMyQZwIzrDS1E1tZiJQ3cb0KHztgkDiq0OxUIMliXzyeWsAzbl2Nhtd/vSnNCnPqXHhRFEtG6lMaoQU+CkNZnn0eeG+Q4O9ZErHCcSVZEISMDXQt/5qxtcngRjfHlUn51hIS0YAwop0i2eu5iefnncM/KChB4dmj+Fk31ytmrxQXaxQgmtKkDxWCuyG701RmBCy2TgnlvWFIdxfcSN23t/R4UemLsj3spIDGqvIrJumqZrHDzgVRU4v7g=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 139baac0-0c7c-4d42-9c16-08d7f7d057e1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 06:30:49.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2LyWkHAvkXortsKUKA02NJFjtHq3W0YvJSKs0hZ2oRaS7WHP6s/xppbTmF3SBTAASZFTwyG0DC1fgaWdbkYVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6961
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Wed 13 May 2020 at 22:57, David Miller <davem@davemloft.net> wrote:
> You put "net-next" in your subject line but failed to include
> netdev in the CC: list.

Sorry. Will resend with proper distribution.

