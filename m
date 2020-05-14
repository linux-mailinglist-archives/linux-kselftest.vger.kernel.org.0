Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1091D27DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 May 2020 08:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgENGa0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 May 2020 02:30:26 -0400
Received: from mail-vi1eur05on2086.outbound.protection.outlook.com ([40.107.21.86]:56088
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgENGaZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 May 2020 02:30:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4jUrUy4e85m+T5iSX8+jND5D7F7t+bw06g21GHyp5QaPvXVhMML1V1yeJHC+XEXgq5jNi8jFaL3kWQQaMM1OvB07TTbGgKpH4b7327lF4Ieb/3dy88WFSI0vG6nVg/1FVbx1EUwuuWM4fof/KlWz2iEBqDA2sU6UAEX+PZaPPvhrpL4sMGSuCBypAdX7swaFYucr/iiPBfF74sqdWXv2TggJeS33tXX8k97NOnxlNiBWU+ePEPcl8va/VnmX9XW12Z76smmVq6oXsAhdT1MQ6bkoVdomHZU3abmj4unLiqK5fA8H9k6gMcXl3w4pe6FxEzf0/miAqDb6ctqTpg4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS63kabMlDHAV3Kw1CT+kIEAz7oHM5hSzhmG+R++aec=;
 b=hKIlcBLACYWOj9rEOOBE1VST6kCjX5wyulpN6mJIpcmIYxsoyWnJImrxYOCHVoy1fRkaZBGfjTukrLAqJ1hEZPl2ENhXyohJ1ziyVMNmwFWAMdBQlur4AdZ9dimYvvGWZJUfC9Y2W7VzvAczgSOYvhy8QmXiv1uIZqFYBODQx0Gs6tMs28RISWOQR0reswZsWDrhsNpCtw7qJg6rxCb6rnMzs4DsSMENn/jHTK9/MSMdvqelQwsK8btnrr+TrKzrH3XoN/QQtwxbV7XFVaRk4A1YLgwAI/GvzQD8cRct7l9oCVr80JCMUVgHtzakAKLIqa55iiwTGrYEGXocr7C7UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JS63kabMlDHAV3Kw1CT+kIEAz7oHM5hSzhmG+R++aec=;
 b=puaH4Py7/YPuPlZrj4fpEYdB37cgFXGl0oDT2JUCR243Udb4j3Zp8UXIIz2wZrbKO62ZtRpx1lQJAza5/d0GziarcSrkFFDBKPZWd6n317ojGDYvFemnsqcuPVYaGXXoJw+8iDbLqH2DYvMMcIfsO6QT9464YEGUMsAmCBhUYlI=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM7PR05MB6995.eurprd05.prod.outlook.com (2603:10a6:20b:1ad::15)
 by AM7PR05MB6883.eurprd05.prod.outlook.com (2603:10a6:20b:1a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24; Thu, 14 May
 2020 06:30:22 +0000
Received: from AM7PR05MB6995.eurprd05.prod.outlook.com
 ([fe80::3903:9c1e:52e0:d74e]) by AM7PR05MB6995.eurprd05.prod.outlook.com
 ([fe80::3903:9c1e:52e0:d74e%6]) with mapi id 15.20.2979.033; Thu, 14 May 2020
 06:30:22 +0000
References: <20200513175746.7294-1-vladbu@mellanox.com> <CAM_iQpX2nBc3ppmvxJPoECCfZY1v1bhiYC_7fjAbXKCqdA3nLg@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2.90
From:   Vlad Buslov <vladbu@mellanox.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     Vlad Buslov <vladbu@mellanox.com>,
        "open list\:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Davide Caratti <dcaratti@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net-next] selftests: fix flower parent qdisc
In-reply-to: <CAM_iQpX2nBc3ppmvxJPoECCfZY1v1bhiYC_7fjAbXKCqdA3nLg@mail.gmail.com>
Date:   Thu, 14 May 2020 09:30:18 +0300
Message-ID: <vbfy2pvxc3p.fsf@mellanox.com>
Content-Type: text/plain
X-ClientProxiedBy: PR1PR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::19) To AM7PR05MB6995.eurprd05.prod.outlook.com
 (2603:10a6:20b:1ad::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from reg-r-vrt-018-180.mellanox.com (37.142.13.130) by PR1PR01CA0006.eurprd01.prod.exchangelabs.com (2603:10a6:102::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Thu, 14 May 2020 06:30:21 +0000
X-Originating-IP: [37.142.13.130]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b8d4021a-4abc-4357-f55c-08d7f7d0478f
X-MS-TrafficTypeDiagnostic: AM7PR05MB6883:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR05MB68830559A3CBE7826990AB63ADBC0@AM7PR05MB6883.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:428;
X-Forefront-PRVS: 040359335D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQAv1kquIUYISNMngsQdMNsJqnZ2OtBEyVb8yOECXjJAJLHPTu508rW4LqLKh4i7zz7GecaPYcRDEQ+j/V4nolM/GB6/xYhUeVRxkSEvhqSURteFoQnUYzXL+nmYX92k6cJjeY2Q7aM12HWPlKLWCzmDW/bSe/hLG3QIuOKtDTIrkcO34SW4itStjE+jDyRqgAv3rr5t4Wqzhq/mVomIGzxj4VEWcymkk7qLwKHjdB7JTAQkTsM3ygW/jmj3hnD34pcqkZ3vSpIgC+vFD4fOFOvYGQUA2RYYFQkRL3gaI4IkfTTlMewCtACZa/YeZs/SHc7gPS2GJuv012rKOheNicIG/40/jWHE37GyHkR6U3g+XDXXI5AxEYzW/RTnoiPX2O6M65BJBmvdm0xaUlkTStWTTiLuMft4rqrXF/fUtvldSjgwX0xY9Lt3Gojl8PDE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6995.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(4744005)(8936002)(478600001)(16526019)(186003)(956004)(2616005)(36756003)(4326008)(26005)(6916009)(7696005)(6666004)(53546011)(52116002)(6486002)(66476007)(66556008)(54906003)(8676002)(86362001)(2906002)(66946007)(316002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: XRlDsszQWikQWZDNCOXT9qNUVbBfxFThMwStzmrpS4IPLwa4Gv6Czd8DadzMQM+5eodFgF3yRfRYTil46V5uUmF2XFnOhrntK6+dOzQPbGm5XcgJ86BYq9i18FGqvsFvx46shYmGaNc7j3qtESjv3riC+GktZn82BDX+f7h7z9laQG5R45eFtNwsolcMHNTiSzx9d9ODUalJpF/SM1QfgywkbRvN+u56Lf+5U0ndj7Hn7tQABEYmrkRWy+tE61wr3mfG7NWgUqF3wQ0fiPCGhwoWz9ZpImXAefiPht0OQYSaVkcE1sCyI+Vvou54aYTYsPQT2O0kFBgbiERMsUmWi+w0hBwk0XRaybvjwTgUhJ6dcshv1GgmIunkJLV/SlrvXRLmjrH25EHnWtBdEM59eA9FKRp0YlgG51a51t39ZR08iUrGgNnW9hkT+tURgw7JDOd7O4dpNE0UZG/Jaw9ezCJRyPY9wkleaO9gSDvCuws=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8d4021a-4abc-4357-f55c-08d7f7d0478f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2020 06:30:22.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cf5CAIEI/ic0bMXVmfKAqq4rsnN8EAJL/YAMCX3jT+Pw/zr1mF2BgZn1EzX+rBqxUb7AOjlzNx+LgaYGWS19yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR05MB6883
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On Wed 13 May 2020 at 21:35, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Wed, May 13, 2020 at 10:58 AM Vlad Buslov <vladbu@mellanox.com> wrote:
>>
>> Flower tests used to create ingress filter with specified parent qdisc
>> "parent ffff:" but dump them on "ingress". With recent commit that fixed
>> tcm_parent handling in dump those are not considered same parent anymore,
>> which causes iproute2 tc to emit additional "parent ffff:" in first line of
>> filter dump output. The change in output causes filter match in tests to
>> fail.
>
> My commit simply restores the old behavior prior to 4.15, so are you
> saying these tests never work correctly on kernels <= 4.15? If so,
> they must be fixed no matter of my commit, right?
>
> Thanks.

I think all of these tests are newer than 4.15.
