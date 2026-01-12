Return-Path: <linux-kselftest+bounces-48790-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54829D151DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 20:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CD4303008190
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 19:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB14B3090EE;
	Mon, 12 Jan 2026 19:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="AcS+Yiif"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F2237180;
	Mon, 12 Jan 2026 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768247068; cv=none; b=r2JywB80YVy9o3EKxthXoLxE4XuGMTFPlN4zKio1BCNC/x90E8+Z1ipmzqc9aYE2nNMMmV+aZL4wedUqyeHLIhmJXjxPCtHxoL3OWKkyhS3614Wcap4U7mcnIyKFPvLc7rYrg98B4m6Gk1i2CG4h0q9UJdrfvlijwoUQIwFmmhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768247068; c=relaxed/simple;
	bh=cFcNvwya3JZIlZDG2Yy9S8tqcSd/UniCTq6TfdCMPBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p9vpI8/lSnyCeQ5LODPfn+dv+GBqVg4ph8yG2xq/Ey+ZWPT5iB4J6DfnLIr4eUxMMS2FKGhsPbh2Eg/C5iFjnoXFD+s2K7WYnGyngmlFaUAIDZ9fpQRjqE5T60/WyG2Iif2OPLDFEjhwWKjoM49nPPAK0hdccuENonr3wdFQgj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=AcS+Yiif; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
X-Virus-Scanned: Yes
Message-ID: <5852adb6-ffa6-43a1-9002-971559adeef6@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1768247062; bh=cFcNvwya3JZIlZDG2Yy9S8tqcSd/UniCTq6TfdCMPBI=;
	h=Subject:To:Cc:References:Reply-To:From:In-Reply-To;
	b=AcS+YiifjaI2Qc7ga2rxeUjVEHhskPJ2bpjP2+4zkPPkkimwRTwVhuNhy1qqERY0q
	 VeR4b0ry8cEhUKb2DPi4lQn7ZERETSDH5e/6lmQ0dXxIp6g2RyNUFL4NUADGG1/eNF
	 wUDgdKnGY1pj33X7kFsS/mcDOwUgpAeU6vGAR2oxInH+I/Qd5p0KzWxZvqZle+izZV
	 DKM28AHf5K/UQLigYsjPNNZG1eQszLVqXWh14hR+Sri3glv6ivkJUMVNyk4LFcrEMR
	 niH27fsbTZDhffKdLZ5byNP9olHHxodp3ZNKQ1wNXn6S+YkLa/xPwPPxpYeuxZ4fJ7
	 D73j9ZBsVYtU8JwPHTn3ppQJoHeTjRK0a6swcEOigi3w5XJW9cxpCun/KhJoVbOgLQ
	 fxIR1dkcELmu0neDfaZe4ciJGBxyBQaBYq+QPUDI6Uq3HClextyZKLaX9fiIRMudwB
	 aqLVXtBRmL/6S+ww1blUqmE/2swwbYLJk3cFa8UYAMpjiXq1tpJqQXkm2wjh6eJ4dY
	 lSw7+v+QjkT8SZ8AfDdnXcgMk0D0yTSPTDckR/prM2MDbca+UNQyph1FW0SY33Xd6A
	 H834smRHSXBvVdBLVoAqBQiPPxCIAravKp3V7qm1+B3E3Z3XL5kf5mBdXl47szqZMK
	 MP8up6zo6QxoVAlK1Ry85Kmw=
Date: Mon, 12 Jan 2026 21:44:20 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 08/19] ublk: move offset check out of
 __ublk_check_and_get_req()
Content-Language: en-GB
To: Caleb Sander Mateos <csander@purestorage.com>, alex+zkern@zazolabs.com
Cc: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Stanley Zhang <stazhang@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20260108091948.1099139-1-csander@purestorage.com>
 <20260108091948.1099139-9-csander@purestorage.com>
 <f0c205d9-609f-4b08-af67-3d8730eb6fce@zazolabs.com>
 <CADUfDZrAx-ALGpNckfZOwR2LUqQMYud9cb14bMp1SW_E12isLg@mail.gmail.com>
Reply-To: alex+zkern@zazolabs.com
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <CADUfDZrAx-ALGpNckfZOwR2LUqQMYud9cb14bMp1SW_E12isLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.01.26 20:29, Caleb Sander Mateos wrote:
> On Mon, Jan 12, 2026 at 10:17 AM Alexander Atanasov <alex@zazolabs.com> wrote:
>>
>> On 8.01.26 11:19, Caleb Sander Mateos wrote:
>>> __ublk_check_and_get_req() checks that the passed in offset is within
>>> the data length of the specified ublk request. However, only user copy
>>> (ublk_check_and_get_req()) supports accessing ublk request data at a
>>> nonzero offset. Zero-copy buffer registration (ublk_register_io_buf())
>>> always passes 0 for the offset, so the check is unnecessary. Move the
>>> check from __ublk_check_and_get_req() to ublk_check_and_get_req().
>>>
>>> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>>> Reviewed-by: Ming Lei <ming.lei@redhat.com>
>>> ---
>>>    drivers/block/ublk_drv.c | 16 +++++++++-------
>>>    1 file changed, 9 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
>>> index e7697dc4a812..8eefb838b563 100644
>>> --- a/drivers/block/ublk_drv.c
>>> +++ b/drivers/block/ublk_drv.c
>>> @@ -253,11 +253,11 @@ struct ublk_params_header {
>>>
>>
>> [snip]
>>
>>> @@ -2603,13 +2603,10 @@ static inline struct request *__ublk_check_and_get_req(struct ublk_device *ub,
>>>                goto fail_put;
>>>
>>>        if (!ublk_rq_has_data(req))
>>>                goto fail_put;
>>>
>>> -     if (offset > blk_rq_bytes(req))
>>> -             goto fail_put;
>>> -
>>>        return req;
>>>    fail_put:
>>>        ublk_put_req_ref(io, req);
>>>        return NULL;
>>>    }
>>> @@ -2687,14 +2684,19 @@ ublk_user_copy(struct kiocb *iocb, struct iov_iter *iter, int dir)
>>>
>>>        if (tag >= ub->dev_info.queue_depth)
>>>                return -EINVAL;
>>>
>>>        io = &ubq->ios[tag];
>>> -     req = __ublk_check_and_get_req(ub, q_id, tag, io, buf_off);
>>> +     req = __ublk_check_and_get_req(ub, q_id, tag, io);
>>>        if (!req)
>>>                return -EINVAL;
>>>
>>> +     if (buf_off > blk_rq_bytes(req)) {
>>> +             ret = -EINVAL;
>>> +             goto out;
>>> +     }
>>> +
>>
>> Offset is zero based, bytes are count so it should be >= here.
>>
>> It will work this way but for buf_off == blk_rq_bytes(req) user will get
>> 0 instead of EINVAL.
> 
> This is the existing behavior in __ublk_check_and_get_req(). I agree
> allowing buf_off == blk_rq_bytes(req) seems odd, but changing it now
> could break ublk servers relying on the current behavior.


I saw it came from the existing version but I doubt that any existing 
server rely on this. In general no code expects to get EOF from a block 
device. It is a user error, classic off by one, to give offset equal to 
the end. If the server have sane error handling it should either detect 
it has a bug and fix it, or does not care at all and work as expected.

The usual pattern is variation of:

while (left > 0) {
     ret = read|write(buf+offset, ....);
     if (ret < 0) goto err;
     left -= ret;
     offset += ret;
}

This gets into a nice infinite loop, and I have actually hit this kind 
of bug in other unrelated code inside the kernel - I guess it is present 
in the original code this is based on.

For example there is/was a case in ext4 that initially returned 0 for a 
write in some edge case but that was changed to return a proper -EAGAIN 
later on iirc to avoid such confusion.

So, if it is not required to be like this by some standard,
it might be worth considering to change.


> Best,
> Caleb
> 
>>
>> static size_t ublk_copy_user_pages(const struct request *req,
>>                   unsigned offset, struct iov_iter *uiter, int dir)
>> {
>>          size_t done = 0;
>> ...
>>           rq_for_each_segment(bv, req, iter) {
>> ...
>>                   if (offset >= bv.bv_len) {
>>                           offset -= bv.bv_len; // bv_len is same as
>> blk_rq_bytes(req)
>>                           continue; // this breaks the loop when ==
>>                   }
>> ...
>>          }
>>          return done; // done is never incremented
>> }
>>
>>>        if (!ublk_check_ubuf_dir(req, dir)) {
>>>                ret = -EACCES;
>>>                goto out;
>>>        }
>>
>>
>> --
>> have fun,
>> alex
>>

-- 
have fun,
alex


