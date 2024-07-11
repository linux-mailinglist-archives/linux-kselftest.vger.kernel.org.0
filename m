Return-Path: <linux-kselftest+bounces-13607-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D3F92ECA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 886A5B20D88
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580916CD1E;
	Thu, 11 Jul 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yYp36Hy8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB508F72;
	Thu, 11 Jul 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720715233; cv=fail; b=Fpnm5PF+1INfhpfk5AkWfy7cclvSAdCY3DIHVBfk/GQHa8lWhYiZS4bI1FDO+YXLonxGuDomtlSOh/AnF4DvIAcLdoq3SUzjecfIp/czo1BwwSYYJhcT6QhM5pqAFkAYEDvYxosBFFia5q3/QhErczQDFfMr7w7rx1yRKUdP9UY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720715233; c=relaxed/simple;
	bh=tGAiE8Dij4rFuvcU9Fh7nwEWShIinKOi/sgnZLfpl08=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tHTsqwooYNYEdfRuxzxy6gLAr9KrAbbvjSsUJic4Qm43vlLn1kUi2z7dSXpPC1J85f+5mikwJhZI0K3Pi6oBo7yIb/GBeOfJdC12e9WSpvChla6beiHzEm2WIwbN+7Fl8utTP4xRSTSwiP0brr/neNm/0kifeEehtrDbUX6NrMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yYp36Hy8; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxKe6RF6/JDZMDyegnvoEArQvy/tI40qDeFglTiNBXroe+lW1C4TUU/Pw2kooR109x3TBIHUO7vRWLA6jyHBo3S2piO89gMVjqYdMT0JaejoQkq/dPiwhHcyhtTk9UFdqNomHIZ535pJ904EJUyXeYXVWiCsp27TPG3V91nkZiAwHeWlxEfLGCTPgy61ltIq02yjdwxHz/nRYRdM0mUisyvpeX1DJb4H5e+zFnEEpddnAbNpUGwCfg/5ICZBugX3BrDh0PKb0AT+XExOaI6t+sI0lj9BF5+6lFQ3xMeyKNQho4UT2UOfqD/yA2Yalc+9bcQ2ky1m7gmPSLYqsABDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwrHzq+do2R211wSt7vrNdSwNBnxnCnD1Qgvn+hHUSU=;
 b=y/YmwJDW4rbTgCGMA4Jh5p8ja0fW7/anNHHdysQAEHodg5eFWmHXIr+RSg5MYoRD7QjQsj6u8pq3uGGfAxsVLMkucl5x0BULZTI0vzUpR7rjexeqgZ+Nhh2/VzuJhN8nf6bi2dCroZNJ4shpBcaEmsPwS0mOrjj7oyu4Ljn35CYspxtEwpM6gzvNHuMrSGrFA9ScHwy8ASWQGINSSEgRrG4M0g9LgcCnD8Ff0R7OKYtvp2kLDLnHKpX7Osaze9K7w4H4xooC9tD/3daqS0xVtIG6aLViDDTGHrSHgMfrdfDFN4RhdZkR+a6yLCaaeUpD951/17yY+zIRVgC6CVhxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwrHzq+do2R211wSt7vrNdSwNBnxnCnD1Qgvn+hHUSU=;
 b=yYp36Hy8u6RRpAxz15cxzEebwrCBka4wvzwpmKpK0Wtvz/k3z/s++02XWGNZD8r0C03+hvbGQxlrhy1WCp1GF3fnEXEgFgJQnUljkvcJ0Ekpf1X6jiw28zV/pfDo5RVfvf8HCcgpnVAn+kw3u2cCeAawDGI2QOxhx7pncm5Im/E=
Received: from SA1P222CA0125.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c5::19)
 by MW3PR12MB4412.namprd12.prod.outlook.com (2603:10b6:303:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Thu, 11 Jul
 2024 16:27:08 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:3c5:cafe::26) by SA1P222CA0125.outlook.office365.com
 (2603:10b6:806:3c5::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Thu, 11 Jul 2024 16:27:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Thu, 11 Jul 2024 16:27:07 +0000
Received: from [10.236.30.66] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 11 Jul
 2024 11:27:06 -0500
Message-ID: <d28efcbd-911a-4ce3-9cb8-3d5b5a872c4d@amd.com>
Date: Thu, 11 Jul 2024 11:27:05 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/5] selftests: KVM: SNP IOCTL test
To: Peter Gonda <pgonda@google.com>
CC: <kvm@vger.kernel.org>, <shuah@kernel.org>, <thomas.lendacky@amd.com>,
	<michael.roth@amd.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-5-pratikrajesh.sampat@amd.com>
 <CAMkAt6ojzv+FYV5Hnvy9whf-TRTxht2C2y4Xnx_VsM_O5G50eA@mail.gmail.com>
Content-Language: en-US
From: "Sampat, Pratik Rajesh" <pratikrajesh.sampat@amd.com>
In-Reply-To: <CAMkAt6ojzv+FYV5Hnvy9whf-TRTxht2C2y4Xnx_VsM_O5G50eA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|MW3PR12MB4412:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cd1d4f6-38df-4b83-9172-08dca1c64ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dW01Z0U1Q3U4L3lqUVBlMzdsbjRhSis2eWdsSkp3dE9QTVg0SlBwZk1LZ1A4?=
 =?utf-8?B?TmpNRjBWNVV0eVBvVnZPSGdlTjNlQzZvbXZqRlVtb1JSZmw4N0pISVFHOTZs?=
 =?utf-8?B?WDJaQk5SVTFSUzZHekQ4SnJDSnVETkE0dWo5OExneE5YRXhtZ2tmSFdDZTFK?=
 =?utf-8?B?cUZuNUVkY3BIYTNNQmU5ekdackpvVDlQTUFFZDM5cmZZSjFSRG93Z2JuQlky?=
 =?utf-8?B?WEJBajRnejlBZnNlK2lGa09yZXJuWkxtbVh6czVqMHVZSVVxRUk3eEczN3Jp?=
 =?utf-8?B?cGxxck1oYXhKOTJOaWtNOXNiczFJSVdtNmpOOGdXUjcxZW5TbXVsRWRVWDRm?=
 =?utf-8?B?MGwrNTRyaXR4bFZtdERaLzRBOFI3MzBJR2YyVzBaOWZ0d2EvZS9xbEY3eE5Y?=
 =?utf-8?B?bThVdHpTOTluZjVYYUZvcGFxVmU2VkxRaktVRngxNXR4NlFRQUIwOExLSFBB?=
 =?utf-8?B?TE0xUHhiT082c1BCYmNtakN5VXg3VkViZjVYdTlnZHAxZFM2RFByWTJCd3Rp?=
 =?utf-8?B?QUhkM09lVE50QzdmRkFLeGtYUkFwWFdDUkxMMmQyVlpiVm5BUGFNSGVVRjVj?=
 =?utf-8?B?R0dhSVhXZXNzaklSc09YbDliUmx6Rm13WitPZFFnY0NwVmxvVGhBcVVWdnBy?=
 =?utf-8?B?djZnNW8vS1g0ZmhpZzUwR2xxejUxS1ZHQzM5VGoyTWczSDMxVXdIU1k5TUI2?=
 =?utf-8?B?SFZiZmJFd1dVK1cwUURWeGl5YnVaajRGRHNhV1dzazJNbVZjNGRSM2dJRWN1?=
 =?utf-8?B?R2YxQURLZW5kWE9xNmg4MkpXaGRubWZIQXlXZzAvMXp6NXAyV1dDdDRURGI0?=
 =?utf-8?B?OVZXTHZpU2hBbmJOKy9sTDFGSStwR1d0c2NWN2xnaFJQSjRkbFcxY2w0U3J6?=
 =?utf-8?B?NUx2Wk9jakVMZlI5TndTZitZY2Z3Q2U2djF1RDlYSnA3UnFYOFZFU1RTUTY1?=
 =?utf-8?B?b1R6WWVvMlNEWW85RXVsd1hoSXhpaDZLbVZsQ1UzZE9TUEJSbXlUOUxrNit5?=
 =?utf-8?B?emhhd3g2Q0lCMFpra2lsOVpFQks0TTBDTFpLckQvSE1LN2E1MDFJL3pzMzdY?=
 =?utf-8?B?NllnZG1EdndLV0N6WkVFVHlrSmpJcmsxUVVnTmtsM21SREY3WDlKNWFScm12?=
 =?utf-8?B?WFB4cHdwRzRiREVFTTJ4L25rRi9DMVZqaWY3Y2dkZ1AvMjRkajVYQ0xVR09k?=
 =?utf-8?B?L1dsTk1NaUVKaG5maHpMSlpodU56dUFPbHA3bFhncXA5Vm1qb3E4MTVsM01S?=
 =?utf-8?B?MktRTmRSU25mOHNhNG1pR3NueW5QQ3B0Z3crdm1qRzh0c1kxa0l0VEFWMyta?=
 =?utf-8?B?RjZEZCtUVXhzTElEOXQxMmZFd0dHd3FzbWFIaTZBei9NZFNXVXdCRzNCODRl?=
 =?utf-8?B?aW40bkhLMFR1QS9laFdidGUwZlpCTUMzYlhJM3ZnNkM5Mld1TU9aZ2lsNkt5?=
 =?utf-8?B?V2lDRFlZRVNDVnhoVDVaWG92WGVCK3RReVdrOXhGRDZldFZEa28vanhMT29x?=
 =?utf-8?B?bW9nK29RSHVWSVhVTGMvb3JidmlnZ096ay9iRi9XUDJyR2xIV3dZRTNKZm5M?=
 =?utf-8?B?Z1MvSy93c1F1V0NKY3pLdGZwcUJkdXdsZ3RQSlRhcnhHdXAveTU3eTdadndr?=
 =?utf-8?B?Qy9XZ1MzdFBqSGp4WmlIZ1prdUdpbVhjbjlteHBZMkZ4b1VVOVo2em5kQnJF?=
 =?utf-8?B?Ulo3TXhVTTFOR000TUZRdHFCY0dtaDFWdjgyNTNJVlN1Uk5rcjlSR2RZQzEv?=
 =?utf-8?B?Y1RSWGxkUGVaeWRLN08ybHh1c0FlZWRWWnJlOTBGcWpDRjZmTkw4bmdOVmtN?=
 =?utf-8?B?bE42K3RUQm1nQUQ1VHN5OVJ1aXRmTEhwN0J1MGRCcTJ1R3VrOGtlQWp1amtp?=
 =?utf-8?B?Y1l3WlZ6bWtEaUxzWmVjMTMyaThCK1gzSVc0MDJ4WW85Q1Z6ZkJrY1E4TEQx?=
 =?utf-8?Q?ytw8nVtYSlIiqReXWDuQuxkVkrfDf506?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 16:27:07.7111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cd1d4f6-38df-4b83-9172-08dca1c64ef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4412



On 7/11/2024 10:57 AM, Peter Gonda wrote:
> On Wed, Jul 10, 2024 at 4:06 PM Pratik R. Sampat
> <pratikrajesh.sampat@amd.com> wrote:
>>
>> Introduce testing of SNP ioctl calls. This patch includes both positive
>> and negative tests of various parameters such as flags, page types and
>> policies.
>>
>> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> 
> Tested-by: Peter Gonda <pgonda@google.com>
> 
>> ---
>>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 119 +++++++++++++++++-
>>  1 file changed, 118 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> index 500c67b3793b..1d5c275c11b3 100644
>> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
>> @@ -186,13 +186,130 @@ static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
>>         kvm_vm_free(vm);
>>  }
>>
>> +static int spawn_snp_launch_start(uint32_t type, uint64_t policy, uint8_t flags)
>> +{
>> +       struct kvm_vcpu *vcpu;
>> +       struct kvm_vm *vm;
>> +       int ret;
>> +
>> +       vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
>> +       ret = snp_vm_launch(vm, policy, flags);
>> +       kvm_vm_free(vm);
>> +
>> +       return ret;
>> +}
>> +
>> +static void test_snp_launch_start(uint32_t type, uint64_t policy)
>> +{
>> +       uint8_t i;
>> +       int ret;
>> +
>> +       ret = spawn_snp_launch_start(type, policy, 0);
>> +       TEST_ASSERT(!ret,
>> +                   "KVM_SEV_SNP_LAUNCH_START should not fail, invalid flag.");
>> +
>> +       for (i = 1; i < 8; i++) {
>> +               ret = spawn_snp_launch_start(type, policy, BIT(i));
>> +               TEST_ASSERT(ret && errno == EINVAL,
>> +                           "KVM_SEV_SNP_LAUNCH_START should fail, invalid flag.");
>> +       }
> 
> To save readers sometime do we want to comment that flags must be zero?
> 

Ack. I can add that comment.

>> +
>> +       ret = spawn_snp_launch_start(type, 0, 0);
>> +       TEST_ASSERT(ret && errno == EINVAL,
>> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy.");
>> +
>> +       ret = spawn_snp_launch_start(type, SNP_POLICY_SMT, 0);
>> +       TEST_ASSERT(ret && errno == EINVAL,
>> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy.");
>> +
>> +       ret = spawn_snp_launch_start(type, SNP_POLICY_RSVD_MBO, 0);
>> +       TEST_ASSERT(ret && errno == EINVAL,
>> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid policy.");
> 
> Ditto on SMT comment, this could pass if SMT was disabled right?
> 

Ack.
Yes, it could. Maybe the check I was speaking about earlier about SMT
can be made here as well and based on that we decide if this should fail
or pass.

>> +
>> +       ret = spawn_snp_launch_start(type, SNP_POLICY_SMT | SNP_POLICY_RSVD_MBO |
>> +                                    (255 * SNP_POLICY_ABI_MAJOR) |
>> +                                    (255 * SNP_POLICY_ABI_MINOR), 0);
>> +       TEST_ASSERT(ret && errno == EIO,
>> +                   "KVM_SEV_SNP_LAUNCH_START should fail, invalid version.");
>> +}
>> +
>> +static void test_snp_launch_update(uint32_t type, uint64_t policy)
>> +{
>> +       struct kvm_vcpu *vcpu;
>> +       struct kvm_vm *vm;
>> +       int ret;
>> +
>> +       for (int pgtype = 0; pgtype <= KVM_SEV_SNP_PAGE_TYPE_CPUID; pgtype++) {
> 
> Do we want to test KVM_SEV_SNP_PAGE_TYPE_CPUID+1 to make sure that fails?
> 

We could. Looking at loop however, we also go through 0x2 which is
undefined so I thought we were already taking care of the negative test
case here. Having said that, I have no issues in adding one more case
that fails.

>> +               vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
>> +               snp_vm_launch(vm, policy, 0);
>> +               ret = snp_vm_launch_update(vm, pgtype);
>> +
>> +               switch (pgtype) {
>> +               case KVM_SEV_SNP_PAGE_TYPE_NORMAL:
>> +               case KVM_SEV_SNP_PAGE_TYPE_ZERO:
>> +               case KVM_SEV_SNP_PAGE_TYPE_UNMEASURED:
>> +               case KVM_SEV_SNP_PAGE_TYPE_SECRETS:
>> +                       TEST_ASSERT(!ret,
>> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should not fail, invalid Page type.");
> 
> Double negative maybe: "KVM_SEV_SNP_LAUNCH_UPDATE should succeed..."
> 

Ack. This double negative is used in a couple of more places. Will clean
them up too.

>> +                       break;
>> +               case KVM_SEV_SNP_PAGE_TYPE_CPUID:
>> +                       TEST_ASSERT(ret && errno == EIO,
>> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should fail, invalid Page type.");
> 
> This is a valid page type right? But I think the error is from the ASP
> due to the page being malformed for a CPUID page.
> 

Yes you're absolutely right. It's technically a correct page type just
not set up correctly to be used this way so we should see it fail.

>> +                       break;
>> +               default:
>> +                       TEST_ASSERT(ret && errno == EINVAL,
>> +                                   "KVM_SEV_SNP_LAUNCH_UPDATE should fail, invalid Page type.");
>> +               }
>> +
>> +               kvm_vm_free(vm);
>> +       }
>> +}
>> +
>> +void test_snp_launch_finish(uint32_t type, uint64_t policy)
>> +{
>> +       struct kvm_vcpu *vcpu;
>> +       struct kvm_vm *vm;
>> +       int ret;
>> +
>> +       vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
>> +       snp_vm_launch(vm, policy, 0);
>> +       snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
>> +       ret = snp_vm_launch_finish(vm, 0);
>> +       TEST_ASSERT(!ret,
>> +                   "KVM_SEV_SNP_LAUNCH_FINISH should not fail, invalid flag.");
> 
> Comment is wrong, maybe: "KVM_SEV_SNP_LAUNCH_FINISH should not fail."
> 

Thanks for catching this. Will fix the comment.

>> +       kvm_vm_free(vm);
>> +
>> +       for (int i = 1; i < 16; i++) {
>> +               vm = vm_sev_create_with_one_vcpu(type, NULL, &vcpu);
>> +               snp_vm_launch(vm, policy, 0);
>> +               snp_vm_launch_update(vm, KVM_SEV_SNP_PAGE_TYPE_NORMAL);
>> +               ret = snp_vm_launch_finish(vm, BIT(i));
>> +               TEST_ASSERT(ret && errno == EINVAL,
>> +                           "KVM_SEV_SNP_LAUNCH_FINISH should fail, invalid flag.");
>> +               kvm_vm_free(vm);
> 
> To save readers sometime do we want to comment that flags must be zero?
> 

Ack.

Thanks again for the review

