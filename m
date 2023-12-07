Return-Path: <linux-kselftest+bounces-1346-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B97808663
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 12:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7934D1C21F36
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Dec 2023 11:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1337D0B;
	Thu,  7 Dec 2023 11:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fxOwyZPh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31C4E9;
	Thu,  7 Dec 2023 03:09:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HD3CDR913mUvKzuHat8qGeUlZTy56h/E574PFyKbK4SL+ixtCeYsu6D7EpV3486r/sqAlL3999MN3sT+J/yr3QVeqmsQUvnZUEhX5/AtvH4mw1FyVQeGyXe8FF2+U3kMkunNfiE9vfi+L8EM6UG/G7C7aFACwHancmoW0Q6Z+KE1TtipP7rhqY4oCW7p87/9IFxyMCaB2tqWBRk/n62VVUJKpBmnhHoVWBldpQoubCpcAoMNjLN+NQqz0COiIR6U5e940SQ0UMByhRKWw5EvXZr1CzUGX87eVoR+4RlcxkPSl3nvg1ovo4Z8taKTl6UMVDT9Y/2oZ8fVUF+7XtVlJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjvMZhJQwez+YCxtmTfhx9UXfozmili3Z0yw3kAkVW4=;
 b=nd1AZY9kVwOlGINVnFY13cpkQ925U/4we/y1uBcilpA+gxcTXsDb/0JxxYlfwfvd7mFMnSXOE7IJCmFFWA+i8lYQMUWRsgfrrZ/L2hzE46qTrpnQgJz7grme/l4cSrABzb17vObmy3UH1jwfZcIaHNMhKy3A7YppwGj86nBbieUi8rsj1aMv6LDU6QQVEDDFHxaMPawyNVgXanNKQ/btG+w4B3rYId3fw8DweQGtXvhqeFnaIrAY7yH2o31BleaCKMZEPz4NveWkYKzyn+KlZmy3aoIfl8CqA6nuG0oyaSen2EE0DwteYq7sizySU8wg9N6LfwMbAejq2D6i76GA5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=katalix.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjvMZhJQwez+YCxtmTfhx9UXfozmili3Z0yw3kAkVW4=;
 b=fxOwyZPh5d1kJZXwVSZ5AZOPZadj5YWHpm4/Rz5IGADjeacshs85Guh6Hyox0VZ5UQ9SNqNejW9m480wT7hKGjRvNUhkgEPKpJShFSmYA4Ie7e16lKr8d/NOGKsfiaEq1OjIzVC/rbVF2jMjgrtFKLROuoWWfAoSP0ZPrH8EtmQ59SqIZx3gl6P32bCqgQ5/Dw5OzmPg6m9onvp8wo1m5+6tyzSPURaJc8LXy5qinvcbTemFLwx/ZIKy7LEP6KBlYH092IlS/ERoMBB5e+QhWQQrTFd24VbVOKwcwX/ANbR3nvdXwqCXKfbAljeQJSVd+VruGtV1xO/OhyP0inDA5Q==
Received: from SN7P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::7)
 by SJ0PR12MB5485.namprd12.prod.outlook.com (2603:10b6:a03:305::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 11:09:43 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::2d) by SN7P222CA0022.outlook.office365.com
 (2603:10b6:806:124::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27 via Frontend
 Transport; Thu, 7 Dec 2023 11:09:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.26 via Frontend Transport; Thu, 7 Dec 2023 11:09:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Dec 2023
 03:09:29 -0800
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 7 Dec 2023
 03:09:24 -0800
References: <20231202020110.362433-1-liuhangbin@gmail.com>
 <20231202020110.362433-2-liuhangbin@gmail.com>
 <7e73dbfe6cad7d551516d02bb02881d885045498.camel@redhat.com>
 <87jzpr5x0r.fsf@nvidia.com>
 <70497ad83be1c7bd715abc8f29c72ee39a381f58.camel@redhat.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Petr Machata <petrm@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<netdev@vger.kernel.org>, "David S.  Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "Shuah Khan"
	<shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>, James Prestwood <prestwoj@gmail.com>,
	Jaehee Park <jhpark1013@gmail.com>, Ido Schimmel <idosch@nvidia.com>, Justin
 Iurman <justin.iurman@uliege.be>, Xin Long <lucien.xin@gmail.com>, James
 Chapman <jchapman@katalix.com>
Subject: Re: [PATCHv3 net-next 01/14] selftests/net: add lib.sh
Date: Thu, 7 Dec 2023 11:34:32 +0100
In-Reply-To: <70497ad83be1c7bd715abc8f29c72ee39a381f58.camel@redhat.com>
Message-ID: <87y1e646cd.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SJ0PR12MB5485:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c6d014-09cd-45e7-a14d-08dbf71502be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	52JnmV76TLbixg0RfQ6sHyX5S2LLO086i79gX4ghU7FezZ1Qo89vpTMp4hsfNkcXsP6TGChz2Z3JDMo8IU/cuugSbJGJ+qtV9PW6sUQ5Jxm6feMnKLLc9WKM5RqO5vY/xb4Mkr4wvTOGllMPcZ36m6IAhgijS9T4XYC/C9BWfO0DADetjoVsRWDxMu8Hdxx0mUr9jcdhZfCZkdD11NlH4tnZGCM70CmIn0e/WrFGJW+EXuqHCx0O48PUumMXHJKtLiPkocoseOJNY7RI5fEZjmn5TeOyod1GtKvo097l+Fmua8FoldhQy53TCFw3IJlJ0vonowC/snFif1bxVp+fWeGN2lR/e+/tkjPN8XOrA/4eCp/wrtdKzBvIJ+c+jFSepAcuBXVh9tbVXi4rvFYpP20HHIKpEPQFlkCmqNkOzrQj3zhZUXHDOE+2glErVQv/hCKgGRy9GOIqiZr91U0wogTW+W8nEpqrf2xsNujiM4X69domBbwQXKY3tj9If6t7GT/HpVA83QGz6NBFq79AImP75MHG2ncyjPah0K/qiiMU37gCZgmHlkTjRQRhr+Rc7eVqO9rCWEONzQsZJPknDZ2NnTmR+xhjjZ92K3sqeocyvfIebuwviiN1KJVLHUAzHG5WrVnn+h3OgQarHCXMGezYYsdv99z+TFSVMHD9pFWCWuwyA/6hffXtsbXnYqlKIqaXygD/fLY48vgRJ8JmXSiel0q9MqRoGHPBfaiK4H+G9ulgXHiYY0TyXhxvxO8+0V+b/v7qLJLNR20oPZpcT41tONsMOhgsRVZ929/d+uw=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(46966006)(36840700001)(41300700001)(83380400001)(336012)(2616005)(5660300002)(86362001)(40480700001)(7416002)(16526019)(2906002)(426003)(26005)(36860700001)(47076005)(40460700003)(356005)(8676002)(4326008)(8936002)(7636003)(6666004)(70206006)(6916009)(70586007)(478600001)(316002)(966005)(36756003)(54906003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 11:09:41.4072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c6d014-09cd-45e7-a14d-08dbf71502be
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5485


Paolo Abeni <pabeni@redhat.com> writes:

> On Wed, 2023-12-06 at 13:32 +0100, Petr Machata wrote:
>> Paolo Abeni <pabeni@redhat.com> writes:
>>=20
>> > Side note for a possible follow-up: if you maintain $ns_list as global
>> > variable, and remove from such list the ns deleted by cleanup_ns, you
>> > could remove the cleanup trap from the individual test with something
>> > alike:
>> >=20
>> > final_cleanup_ns()
>> > {
>> > 	cleanup_ns $ns_list
>> > }
>> >=20
>> > trap final_cleanup_ns EXIT
>> >=20
>> > No respin needed for the above, could be a follow-up if agreed upon.
>>=20
>> If you propose this for the library then I'm against it. The exit trap
>> is a global resource that the client scripts sometimes need to use as
>> well, to do topology teardowns or just general cleanups.=C2=A0
>> So either the library would have to provide APIs for cleanup management,=
 or the trap
>> is for exclusive use by clients. The latter is IMHO simpler.
>
> Even the former would not be very complex:
>
> TRAPS=3D""
> do_at_exit() {
>         TRAPS=3D"${TRAPS}$@;"
>
>         trap "${TRAPS}" EXIT
> }
>
> And then use "do_at_exit <whatever>" instead of "trap <whatever> EXIT"

Yep. I mentioned this during v2 review:

    https://github.com/pmachata/stuff/blob/master/ptp-test/lib.sh#L13

Not much code at all, though you need to convert all EXIT trap users to
this contraption. Again, a mechanical process, just needs to be done.

>> It also puts the cleanups at the same place where the acquisition is
>> prompted: the client allocates the NS, the client should prompt its
>> cleanup.
>
> I guess I could argue that the the script is asking the library to
> allocate the namespaces, and the library could take care of disposing
> them.

It could also be said that since the script asked for NS creation, the
script should ask for NS disposal :)

But what I object against is that the library uses trap without having a
way for user scripts to schedule at-exit work, because that's used
literally everywhere in forwarding tests. If people are willing to do
the conversion, I'm OK with that.

> But I'm not pushing the proposed option, if there is no agreement no
> need for additional work ;)
>
> Cheers,
>
> Paolo


