Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9081D0FE5
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 May 2020 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732556AbgEMKdd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 May 2020 06:33:33 -0400
Received: from mail-eopbgr140077.outbound.protection.outlook.com ([40.107.14.77]:55165
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732204AbgEMKdc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 May 2020 06:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFHUIGRwBaiw/+OYaUfFpl0xfYu+FKyka+343f5hLc0=;
 b=lJx7sXGJNsxN2Uq5gtIoBn+8LkOfWn9eDOM/J3sAjwRaKzjX4G8qtNh2vkrUV2t+bKm2zpY7YkTEUKMLVGgPnI1LzuVdlDOl8+Nv6+dwRXLvRMwHgqkDFCapsyBx9+5crzqdoDlVagunwT+HHmdC9CA1Xk7eRCeh4S75L1G0lRQ=
Received: from DB3PR06CA0022.eurprd06.prod.outlook.com (2603:10a6:8:1::35) by
 AM5PR0802MB2594.eurprd08.prod.outlook.com (2603:10a6:203:99::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Wed, 13 May
 2020 10:33:28 +0000
Received: from DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::a9) by DB3PR06CA0022.outlook.office365.com
 (2603:10a6:8:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend
 Transport; Wed, 13 May 2020 10:33:28 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT027.mail.protection.outlook.com (10.152.20.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.19 via Frontend Transport; Wed, 13 May 2020 10:33:28 +0000
Received: ("Tessian outbound 567b75aed2b9:v54"); Wed, 13 May 2020 10:33:28 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b9697ace434919c7
X-CR-MTA-TID: 64aa7808
Received: from 509c49209916.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id CEFE2D29-B94A-4535-8601-CFB4A4CA1D91.1;
        Wed, 13 May 2020 10:33:23 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 509c49209916.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 13 May 2020 10:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyRAj8INYKfi7EM5UrXxlfd+pr61Ud0zllAwbwklXh+cPsuCIawW7h+/SbQG5MuA1ixNlgPol+Wdc5+hv9UxFpFyoraRSK9rmzqehIsqsFURi7GUT2vwsA3hfQKOspnOypeya+RLjIIcUqr3fYk2LzhpFfi3A1CyP92aj5z3vpdx6m4FuWJpyjrSMlvJDGhAbB+Kcypa/Dj6WR+YzDmQ4ATC706Oop3ImseLJyvgifqNyF8s88wSqfIWYWeUp41fleoxS+iDqDdhF9mQLBEIlLAWRhJpfIGngAg4+rNgr2JjYk8joMu70vhtTwzZXqcrAF2K8sAm3jYTQafWeupR0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFHUIGRwBaiw/+OYaUfFpl0xfYu+FKyka+343f5hLc0=;
 b=karisgpGdmGhy0Cgd/yURwNqx4mdq4n4ycyZkBTq/E0V4LHEhdvSmj4RrCht8dsqzkE5p7ADS9BH7y+WIe3SAk7BOkL/O77QSbuG8o79K94LjTVgqIS3Xi2+e83g92wLy7UEnXp0JJQ6bSHuvTg6cPQ7yWTNxIEK7zQWAFi6xlzlNTeDFCMS1kMldN14oXr803Zsf15BORDzB6NvrlC+/arOnPE5hRF/B74GsihcqYr3PhvRAR0K/GKgLZeLYa/SXOfpxhv8xjni/zBwz62BphMUrQo/wungbPVhy5HOj6+vUBWUyigH+qw8fZBItAVw1dsM5mPrhwZQDvkB0nkjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFHUIGRwBaiw/+OYaUfFpl0xfYu+FKyka+343f5hLc0=;
 b=lJx7sXGJNsxN2Uq5gtIoBn+8LkOfWn9eDOM/J3sAjwRaKzjX4G8qtNh2vkrUV2t+bKm2zpY7YkTEUKMLVGgPnI1LzuVdlDOl8+Nv6+dwRXLvRMwHgqkDFCapsyBx9+5crzqdoDlVagunwT+HHmdC9CA1Xk7eRCeh4S75L1G0lRQ=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from HE1PR08MB2890.eurprd08.prod.outlook.com (2603:10a6:7:36::11) by
 HE1PR08MB2763.eurprd08.prod.outlook.com (2603:10a6:7:36::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.29; Wed, 13 May 2020 10:33:11 +0000
Received: from HE1PR08MB2890.eurprd08.prod.outlook.com
 ([fe80::21af:7992:3558:1a80]) by HE1PR08MB2890.eurprd08.prod.outlook.com
 ([fe80::21af:7992:3558:1a80%2]) with mapi id 15.20.2958.035; Wed, 13 May 2020
 10:33:11 +0000
Date:   Wed, 13 May 2020 11:33:09 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Laura Abbott <labbott@redhat.com>,
        "Andrew F. Davis" <afd@ti.com>, linux-kselftest@vger.kernel.org,
        nd@arm.com
Subject: Re: [PATCH] kselftests: dmabuf-heaps: Fix confused return value on
 expected error testing
Message-ID: <20200513103309.b3zbyuftto6yjidc@DESKTOP-E1NTVVP.localdomain>
References: <20200508045610.80522-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508045610.80522-1-john.stultz@linaro.org>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::15) To HE1PR08MB2890.eurprd08.prod.outlook.com
 (2603:10a6:7:36::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (217.140.99.251) by LO2P123CA0003.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:a6::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20 via Frontend Transport; Wed, 13 May 2020 10:33:10 +0000
X-Originating-IP: [217.140.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4fa1ceb5-ea88-40e0-cba7-08d7f7291331
X-MS-TrafficTypeDiagnostic: HE1PR08MB2763:|AM5PR0802MB2594:
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2594FB7DB0AB13C0242C1DB3F0BF0@AM5PR0802MB2594.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;OLM:1728;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yVsmh6EiTh3mpEdgWvBo2XHTwrEea16HSup6YxE/r9ScLpoK48ZmZ3SjdbJqu2hOdJSESwHtmLR5SJ96+NSgRUuxnaNkpKUVCxP5U6eIZcPWRUNDs0FfzHbAddCvWzXHI2/HyDgD84Sta4njGCCD3mnqGiGt8D+/EtQ2hT5ur7kyjR7VYn1ePe+f6O+NK/GDu7OI1PbKBPyca0Ue/5wJX0xBwTYdgLLux7gefPS/7oMem02E5rz4VMWHzG+tlrglJvV+NZCuqn7fhNLROcNbcPZfQ6Ulatrso9TkvWQClQx18bsSJvMT6xQUPuf0NKO4ESpL6yad39m99cWHE5dugy6KxamYor6o6VvQ43IDOwQKJNdKGJZ6LJIH8LzZSc9NhwDSx7kKw4oQlqIcUwTqjs5sb/rUL6JdCGGiPAZRvs4rOHE7iPFt9mlWLbNaH0PlOPT5aw986HxFzaa5nskRA2CRYIa4aZ0ksDnFu/4e2EyqXvLU9rTa4F7e5Wh5zsBs+BVm+g/hovWMfTwDo/Picw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR08MB2890.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(346002)(396003)(136003)(376002)(366004)(33430700001)(33440700001)(6916009)(7696005)(2906002)(54906003)(9686003)(478600001)(5660300002)(8676002)(6506007)(1076003)(316002)(8936002)(52116002)(26005)(66556008)(55016002)(186003)(16526019)(956004)(86362001)(66476007)(66946007)(44832011)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2GA2nF6NfWUUMY4v4k+Ew6H0k0iFmNPf5rORy7Bb54TFB2jSxTAiEDAk3nGaSgF4RMlbqtiXSCYKSYGkzN4BSibujOtKruf8puNGrRIn2aaCG/S85b+AwhL7C2qfoRHIp+ylq0FheXMyjpqLjrxdJF0ERgJQXJtJLeCP9esZYbhe1+FMH2cebhwrhnPX8tQiiqA+CloDQDQw2zm28m460lwNpndRCugkTVWduLTSJ4hvReF7ofaodi1MBp5Drz9by6sSLITeXCkuL9MNNlgm8mCDesiKuH9vk9G3za5KzUDhZ3z90xlawRcRX/dRtks9YEUBT3W76s0k9gXVkM0aW6RijavAEB7ECyKnHEOZkr59LfwR3L6HB1AQo8PwpAMIlKpKV48adimXYlWgBMRJUxxrMIHcenOXbjCUhJS62pfsapBzPx/Wg2PHpYjSpX1AJ8qERtZl88ouiSQ1ixQjbhxYTEUf3xoQol85cGVjKJeoX+nwNezGAaTx28dsrgYd
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2763
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT027.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39850400004)(396003)(136003)(376002)(46966005)(33430700001)(450100002)(6506007)(70586007)(54906003)(82740400003)(81166007)(86362001)(44832011)(55016002)(9686003)(7696005)(336012)(16526019)(6862004)(47076004)(186003)(956004)(4326008)(26005)(5660300002)(8676002)(70206006)(478600001)(1076003)(316002)(8936002)(356005)(2906002)(33440700001)(82310400002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 09fd0816-7857-49ee-ed35-08d7f72908b3
X-Forefront-PRVS: 0402872DA1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ouQJXyjw5LjFafiifuf6DERqlDFBQc0zhkMEoYBCZlNtT2OfRaiCngncGX2QcRmIrw9b2RQfFyjy67fdlfgI+XR99+Dzu1qeRdZ7wb8B4uqbVzZ2/VDmMeHZ6+FiwPVTtyZ09xegHbt1A2aB5khqHDsfNOiqYNLLQp2z/JUJsVt3gs3zrSV8lQbAIlZFttZgUaEXAytuaK16rU64ZayyjEjmqiE+vtldvou1qr+iuXE9b1XJNmXXZWw0MwyhCi/rL9Ri9UGxQQEROscExqwiR70qP9W8BGvRmZGEC8K9T8Dn/oVEcKZU6XECr0VWMWl8yc+5BQTW1LZoulPSXOULM+AviJdL+/guzGkA4DquEHR12lWcOmod0JJZHMrj6LhqzfpWJyjgxVMSuth+W2I+PwQMcWf36GGMoymCXG3EDZtkXUOkNw42Pk4CNph0yucbhDs1631CDIh48Eu9JfkFRia6gO9P1J7ALNUbw3tcY7MwIkjtflNHgjEQra0jBosV+ZzsZ2Cb96USbVL7N6/EXVWhggIYkXo8U3TTIM/paMKvxx2tHUF8tBb8mw4X54gS7L57+/lQSo7X05eJ5dmlvQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 10:33:28.3864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa1ceb5-ea88-40e0-cba7-08d7f7291331
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2594
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi John,

On Fri, May 08, 2020 at 04:56:10AM +0000, John Stultz wrote:
> When I added the expected error testing, I forgot I need to set
> the return to zero when we successfully see an error.
> 
> Without this change we only end up testing a single heap
> before the test quits.
> 

The fix looks fine - feel free to add my r-b.

However taking a new look at the tests, what do you think about
conceptually replacing the 'break's with 'continue's? Is there a
reason to skip all the other heaps if one of them fails a test?

Thanks,
-Brian

> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> Cc: Brian Starkey <brian.starkey@arm.com>
> Cc: Laura Abbott <labbott@redhat.com>
> Cc: "Andrew F. Davis" <afd@ti.com>
> Cc: linux-kselftest@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index cd5e1f602ac9..909da9cdda97 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -351,6 +351,7 @@ static int test_alloc_errors(char *heap_name)
>  	}
>  
>  	printf("Expected error checking passed\n");
> +	ret = 0;
>  out:
>  	if (dmabuf_fd >= 0)
>  		close(dmabuf_fd);
> -- 
> 2.17.1
> 
