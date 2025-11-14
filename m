Return-Path: <linux-kselftest+bounces-45608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D8C5B801
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707813B51A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 06:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2A62EA47E;
	Fri, 14 Nov 2025 06:25:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B52A2737F6;
	Fri, 14 Nov 2025 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763101512; cv=none; b=Akg54rSYw1fRB3igKH1jAM4HCQUUnPO/2E+mJbtpDL1KefTj8YcO7/u92fM/i2i8o3xeJ3n9uE68RZB14U0GnpEQblmsADiJ1BMqdxKpd8J3ty36VouidCqZmtGgjsepC85uuvyro6/wlNYcrmsBVU6kQtusKqE9kWtMkDsCoNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763101512; c=relaxed/simple;
	bh=pluKasjMBI++oikhGEAmegOy2Qt8kYnGX7Zu65GPm8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGk2iIevWoxg+phvsrQ6bH30w5auoYErY94ROayoEVlYlOpqYCxhlAy2jJSJOoXCQNKo7PeFoUxrrYK1yyQ9F78T6kEzJnlNPwWT5OJBS8GqQcQ/28M0bOEADJQZTZMtl1883lZ8WyKicusML9DOh9f/u9gHxFEkppU1JSLwsi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a5d9b66cc12211f0a38c85956e01ac42-20251114
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:c3be2ef7-6be5-4c4d-a15c-29481c602624,IP:10,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:5
X-CID-INFO: VERSION:1.3.6,REQID:c3be2ef7-6be5-4c4d-a15c-29481c602624,IP:10,URL
	:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:5
X-CID-META: VersionHash:a9d874c,CLOUDID:0e7428f221067420a56c4f77f23e8144,BulkI
	D:251113225812EYOJ6GI2,BulkQuantity:5,Recheck:0,SF:17|19|64|66|78|80|81|82
	|83|102|841|850,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:1,File:nil,RT:nil,
	Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR
	:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a5d9b66cc12211f0a38c85956e01ac42-20251114
X-User: sunshaojie@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sunshaojie@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 98325181; Fri, 14 Nov 2025 14:25:00 +0800
From: Sun Shaojie <sunshaojie@kylinos.cn>
To: mkoutny@suse.com
Cc: llong@redhat.com,
	chenridong@huaweicloud.com,
	cgroups@vger.kernel.org,
	hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	tj@kernel.org
Subject: Re: [PATCH v2] cpuset: relax the overlap check for cgroup-v2
Date: Fri, 14 Nov 2025 14:24:48 +0800
Message-Id: <20251114062448.685754-1-sunshaojie@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
References: <19fa5a93-4cc9-4f84-891c-b3b096a68799@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Michal

On 2025/11/14 01:07, Michal Koutný wrote:
>On Thu, Nov 13, 2025 at 09:14:34PM +0800, Sun Shaojie <sunshaojie@kylinos.cn> wrote:
>> In cgroup v2, a mutual overlap check is required when at least one of two
>> cpusets is exclusive. However, this check should be relaxed and limited to
>> cases where both cpusets are exclusive.
>> 
>> The table 1 shows the partition states of A1 and B1 after each step before
>> applying this patch.
>> 
>> Table 1: Before applying the patch
>>  Step                                       | A1's prstate | B1's prstate |
>>  #1> mkdir -p A1                            | member       |              |
>>  #2> echo "0-1" > A1/cpuset.cpus            | member       |              |
>>  #3> echo "root" > A1/cpuset.cpus.partition | root         |              |
>>  #4> mkdir -p B1                            | root         | member       |
>>  #5> echo "0-3" > B1/cpuset.cpus            | root invalid | member       |
>>  #6> echo "root" > B1/cpuset.cpus.partition | root invalid | root invalid |
>> 
>> After step #5, A1 changes from "root" to "root invalid" because its CPUs
>> (0-1) overlap with those requested by B1 (0-3). However, B1 can actually
>> use CPUs 2-3, so it would be more reasonable for A1 to remain as "root."
>
>I remember there was the addition of cgroup_file_notify() for the
>cpuset.cpus.partition so that such changes can be watched for.
>
>I may not be seeing whole picture, so I ask -- why would it be "more
>reasonable" for A1 to remain root. From this description it looks like
>you'd silently convert B1's effective cpus to 2-3 but IIUC the code
>change that won't happen but you'd reject the write of "0-3" instead.
>

The desired outcome is that after step #5, although B1 writes "0-3" to 
cpuset.cpus, A1 can still remain as "root", and B1 ends up with effective 
CPUs of 2-3. In summary, We want to avoid A1's invalidation when B1 
changes its cpuset.cpus. Because cgroup v2 allows the effective CPU mask 
of a cpuset to differ from its requested mask.

Indeed, this issue was discussed in detail during the v1 review.
https://lore.kernel.org/cgroups/c8e234f4-2c27-4753-8f39-8ae83197efd3@redhat.com/T/#u

>Isn't here missing Table 2: After applying the patch? I'm asking because
>of the number 1 but also because it'd make the intention clearer
>;-), perhaps with a column for cpuset.cpus.effective.

Thanks for the suggestion. I will update the patch description accordingly.

Thanks,
Sun Shaojie

