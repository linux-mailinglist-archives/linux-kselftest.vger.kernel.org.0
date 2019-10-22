Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E671E04F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2019 15:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbfJVN1W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 22 Oct 2019 09:27:22 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:64668 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728346AbfJVN1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 22 Oct 2019 09:27:22 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9MDOY9S005581;
        Tue, 22 Oct 2019 06:27:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pfpt0818; bh=XJwpKbL0wQuneL7UFcyKFCGDMcnnotvapzSaB7HFTCk=;
 b=gfn9El6QmlCtFnMctUY3Wi8dURn5JdYjz6meMbnhT5Bgq7IM0H7hkmzjoqsowjFOVvj+
 CPBtj/QF7skGjAfPOsLd5SRUEp7N2goCkQ7UUbmjZVXEqGv0cA3ClYlIUA6cWoubDF5X
 iWhxNwzgYvBnkZer8Uk1OIP5qs1qZIXBy+InxASRoQxpuK/cyZKjm+gKBrZRMq/1+ERv
 7cr/CYQVr8dEsKNJ+UmdzJHpA4qZR0lHVm6Dam2XGBTgxiLKvNy+f6p6kbSdcIJLyzNF
 dO64e35oA//R3S0vw08zCuN33d6uRnV20V7d7wsU6dI6DOUuvi9CEngS30fn0YdvsqH1 qw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2vsyjh8kw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 22 Oct 2019 06:27:20 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Tue, 22 Oct
 2019 06:27:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.53) by
 SC-EXCH01.marvell.com (10.93.176.81) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 22 Oct 2019 06:27:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVbbWy0yUE40YFWz4p59lft5tYOhIHQP9rtiahl8bLnHzciOxDEYdONEHmBJmvNJBiH1h1KTSpg7+7CTqR4sU6Mc31Sw0QAzU21/D9kczMsTmo7bblisG1onhlvWksXDKAvuEpq2TLZjMf5kJE4yDxjDq/5Nts9oqJEaNRs40ifZv7hrgdO5bwoAw7lc9acjV+LBxuOCpOZVxAAOQ11mnCFgtOw1DRpaqbhUbvT6oicKIboKt9Ffb0P7DQvSBklddHH08BYYXolCuqBWopwsxmcJk7a6n3N/fqXAj3L/wqObmrFEue3zR3LGMEdiqe4/AbrJi0SEH7pfGwQZ0DHSww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJwpKbL0wQuneL7UFcyKFCGDMcnnotvapzSaB7HFTCk=;
 b=KJ6wbdY0FcNPPCSWSIntaYVCbq5ZiZAjOV0BDgHW2tOnYlh4t078+A4VssNk/sBXML8AUe5bY70gBBrn56VbQA/kLMTV7KWzTJfSf/gsoyhgijJ+h8Ba+/M0215FYHZPJju9/WbR0vQGWJn0oJ+GUx7e1KzaJiVRUhlapHKrr9n1Bg6t3R0WPMlfKH6E1aiaskgCAzwOAN6VNBBr3rr5wSClzNDJYJcd0TygEDHl+HG8SpJ3cDF3zgwAFl3IEzTY4k+sWBKvoXOVdCARJhJe3ow6brzaCZXgyCW8xyU+MSUFtEoHxd4oanDXCFDn/ynuF/oo+86R6Pm73/Xz9yJR7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJwpKbL0wQuneL7UFcyKFCGDMcnnotvapzSaB7HFTCk=;
 b=M+nnIX02jhPn0c06D3kaKzprvH05gzeweemHnHRAIJ99eboWPXz5mcU5Hjak/NLTycN1sjcLs6peD5uGllaeZtX88+Y3OpOKDLMj/fA8t8r9TdWIc2/3qd9PFLJhjJBmM0SPibeNq37qxsPrx+nPIVFYcjP06sxJTy6KT1v3O4A=
Received: from MN2PR18MB2989.namprd18.prod.outlook.com (20.179.23.97) by
 MN2PR18MB2864.namprd18.prod.outlook.com (20.179.20.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Tue, 22 Oct 2019 13:27:17 +0000
Received: from MN2PR18MB2989.namprd18.prod.outlook.com
 ([fe80::20e2:230e:2d69:be1f]) by MN2PR18MB2989.namprd18.prod.outlook.com
 ([fe80::20e2:230e:2d69:be1f%5]) with mapi id 15.20.2367.022; Tue, 22 Oct 2019
 13:27:17 +0000
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
CC:     "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "Prabhakar Kushwaha" <pkushwaha@marvell.com>
Subject: [PATCH][v3] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
Thread-Topic: [PATCH][v3] kselftest: Fix NULL INSTALL_PATH for TARGETS runlist
Thread-Index: AQHViNxsZ5Xn2h4gK0eZTapE5OUYNg==
Date:   Tue, 22 Oct 2019 13:27:17 +0000
Message-ID: <1571750829-28944-1-git-send-email-pkushwaha@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:180::25) To MN2PR18MB2989.namprd18.prod.outlook.com
 (2603:10b6:208:a5::33)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.8.3.1
x-originating-ip: [199.233.59.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 816506c5-e78e-436a-e01a-08d756f38f09
x-ms-traffictypediagnostic: MN2PR18MB2864:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR18MB28649BE30F8AD589E8AA2D22B2680@MN2PR18MB2864.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:541;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(199004)(189003)(7736002)(107886003)(6116002)(305945005)(4326008)(3846002)(52116002)(99286004)(71190400001)(71200400001)(6486002)(2906002)(54906003)(316002)(36756003)(5640700003)(6512007)(6436002)(81156014)(6916009)(4720700003)(25786009)(81166006)(8676002)(8936002)(14454004)(50226002)(478600001)(86362001)(5660300002)(386003)(6506007)(102836004)(2616005)(26005)(476003)(14444005)(256004)(2501003)(486006)(66066001)(66446008)(64756008)(66946007)(66476007)(66556008)(2351001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2864;H:MN2PR18MB2989.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CD5xpETgK9lSIch33idC99jL20Ov/+hF4dC1K3519w11CRz0eV78tXuGamyaW/8xv5IDH1RU6vRzcftj+mTfYMMurOUBrONEFReXzcK73Dg02dXtNqOkujOaXK6OWwMshUBYWW+DWwNUIycjsvryrJPY687KLk3Leplg8jFQPRV+z9M7liBjiIO7PGQ7BPNLwhoTvKUcRJiHdptHS5/8TsMyiNmjuNMAaiKDh46woknsNveOAT09bd5COSXv5VdRKbtcx1mBRuvWVLR2h2/mPCV8nRidT1k4rPgnR03eUDvAWtkjGGvwkBzzIyHFzrIdWfTrvkIek8vIMIPIvep9W8CalFT/zEkPd4lwYo2Etxw26Us8qRL9gXKGpnhjNDB+WKXJJo1m/OxBwEyAlDQjU2n1n3O15LtnsCZrPUDUggNZ0xlV/NoA9xcSG827xjH+
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 816506c5-e78e-436a-e01a-08d756f38f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 13:27:17.5703
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7kIjGf9wUjJZwyHD6ZW0SyA4YLY9PzT+a4MjBqHonNpYhwUDfmzcubMadQ6ksfqJaJPvOwW/1u9cOXUgEsLk/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2864
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_03:2019-10-22,2019-10-22 signatures=0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As per commit 131b30c94fbc ("kselftest: exclude failed TARGETS from
runlist") failed targets were excluded from the runlist. But value
$$INSTALL_PATH is always NULL. It should be $INSTALL_PATH instead
$$INSTALL_PATH.

So, fix Makefile to use $INSTALL_PATH.

Fixes: 131b30c94fbc ("kselftest: exclude failed TARGETS from runlist")
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
---
Changes for v2: Fix Author mail id
Changes for v3: Added tag


 tools/testing/selftests/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Mak=
efile
index 4cdbae6f4e61..612f6757015d 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -213,7 +213,7 @@ ifdef INSTALL_PATH
 	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=3D$$BUILD/$$TARGET;	\
-		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$T=
ARGET" && continue; \
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$=
TARGET" && continue; \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" =
>> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
--=20
2.17.0

