Return-Path: <linux-kselftest+bounces-47901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B04D0CD7CBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 03:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 608D5314BD5F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E32237707;
	Tue, 23 Dec 2025 01:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8BmJj4v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AA2405ED
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 01:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766454703; cv=none; b=lya9rrfSh1zigCS4AclmCdSuc+KGJd4ngaBaw53Wuyvcfj08B/NnZLrn8SG7Y3RxOifke/7YZDWK3RuBpuYtLxFo2ZUIbCQcPNodhh8Y4TmfCnYm7UdX2G+BH9ZyLWU9N21881N8epIsYTVEdtiMi18t9dnNfhS7UIbxUBXzW6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766454703; c=relaxed/simple;
	bh=Kuo7K4RLDm3D/4aKICIh1JjqGgqzCGr/l78acdLGogs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O474un0hwh5D6u0zCiotonbvE3idxqjABJQhWPwIxynuznZAV4z7HaGSRvuqXNFwABeLBFY1O8vXT2OTYXU3gfhNt+DR7hcKdXxF2AiYqTGImLR7kNS+uc0ic1BWRdOdaqFqedsuMyM7wEWJIN2Rx3RGR7O+F4PKSF3vlkPlb18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8BmJj4v; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766454700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVyvMHdYiOMJZDAaiQoHIi0uYkIFR3AXDiu2W4PmloY=;
	b=c8BmJj4vLgbJ9f3yPItpRiINobcjyuA+1jNURe1LzrwUMaeRtMRENwKGCPzzM6B6L74Zle
	+9puwpYhmw88JV7bys1c9+iYFTbue14RfUAsnbnUpVbg+qbJhQwOhh408nyQbIUrPTbtND
	7nIohRLJWLL/Pdkn85OTY07Nk0kfqPc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-rK7-h6PVPca3x8lk0ywOPg-1; Mon,
 22 Dec 2025 20:51:36 -0500
X-MC-Unique: rK7-h6PVPca3x8lk0ywOPg-1
X-Mimecast-MFC-AGG-ID: rK7-h6PVPca3x8lk0ywOPg_1766454695
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 306FE180028B;
	Tue, 23 Dec 2025 01:51:35 +0000 (UTC)
Received: from fedora (unknown [10.72.116.97])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A62B180066E;
	Tue, 23 Dec 2025 01:51:30 +0000 (UTC)
Date: Tue, 23 Dec 2025 09:51:25 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>,
	linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stanley Zhang <stazhang@purestorage.com>,
	Uday Shankar <ushankar@purestorage.com>
Subject: Re: [PATCH 04/20] ublk: add integrity UAPI
Message-ID: <aUn1nac8ZONTAdud@fedora>
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-5-csander@purestorage.com>
 <aUlVDtLgPh6NCWsC@fedora>
 <CADUfDZp5Or_Q+7HKtdi97n5kBpQ=zpOFAtqfatR3nu+=yGLb_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZp5Or_Q+7HKtdi97n5kBpQ=zpOFAtqfatR3nu+=yGLb_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Mon, Dec 22, 2025 at 10:09:50AM -0500, Caleb Sander Mateos wrote:
> On Mon, Dec 22, 2025 at 9:26 AM Ming Lei <ming.lei@redhat.com> wrote:
> >
> > On Tue, Dec 16, 2025 at 10:34:38PM -0700, Caleb Sander Mateos wrote:
> > > From: Stanley Zhang <stazhang@purestorage.com>
> > >
> > > Add UAPI definitions for metadata/integrity support in ublk.
> > > UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity allow a ublk
> > > server to specify the integrity params of a ublk device.
> > > The ublk driver will set UBLK_IO_F_INTEGRITY in the op_flags field of
> > > struct ublksrv_io_desc for requests with integrity data.
> > > The ublk server uses user copy with UBLKSRV_IO_INTEGRITY_FLAG set in the
> > > offset parameter to access a request's integrity buffer.
> > >
> > > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > > [csander: drop feature flag and redundant pi_tuple_size field,
> > >  add io_desc flag, use block metadata UAPI constants]
> > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > > ---
> > >  include/uapi/linux/ublk_cmd.h | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cmd.h
> > > index ec77dabba45b..5bfb9a0521c3 100644
> > > --- a/include/uapi/linux/ublk_cmd.h
> > > +++ b/include/uapi/linux/ublk_cmd.h
> > > @@ -129,11 +129,15 @@
> > >  #define UBLK_QID_BITS                12
> > >  #define UBLK_QID_BITS_MASK   ((1ULL << UBLK_QID_BITS) - 1)
> > >
> > >  #define UBLK_MAX_NR_QUEUES   (1U << UBLK_QID_BITS)
> > >
> > > -#define UBLKSRV_IO_BUF_TOTAL_BITS    (UBLK_QID_OFF + UBLK_QID_BITS)
> > > +/* Copy to/from request integrity buffer instead of data buffer */
> > > +#define UBLK_INTEGRITY_FLAG_OFF              (UBLK_QID_OFF + UBLK_QID_BITS)
> > > +#define UBLKSRV_IO_INTEGRITY_FLAG    (1ULL << UBLK_INTEGRITY_FLAG_OFF)
> > > +
> >
> > I feel it is more readable to move the definition into the patch which uses
> > them.
> 
> Sure, I can do that.
> 
> >
> > > +#define UBLKSRV_IO_BUF_TOTAL_BITS    (UBLK_INTEGRITY_FLAG_OFF + 1)
> >
> > It is UAPI, UBLKSRV_IO_BUF_TOTAL_BITS shouldn't be changed, or can you
> > explain this way is safe?
> 
> It's not clear to me how userspace is expected to use
> UBLKSRV_IO_BUF_TOTAL_BITS. (Our ublk server, for one, doesn't use it.)
> Can you provide an example? It looks to me like the purpose is to
> communicate the number of bits needed to represent a user copy offset
> value, in which case it makes sense to include the integrity flag now
> that that bit is being used.

Yes, it is used for this purpose.

Now one new bit(bit 53) is added for marking if it is for meta user copy,
let's keep UBLKSRV_IO_BUF_TOTAL_BITS cover its original meaning, and not
include the new bit UBLKSRV_IO_INTEGRITY_FLAG, which can be documented.

Then it can avoid some trouble, such as, break some uapi header checker at
least.

> 
> >
> > >  #define UBLKSRV_IO_BUF_TOTAL_SIZE    (1ULL << UBLKSRV_IO_BUF_TOTAL_BITS)
> > >
> > >  /*
> > >   * ublk server can register data buffers for incoming I/O requests with a sparse
> > >   * io_uring buffer table. The request buffer can then be used as the data buffer
> > > @@ -406,10 +410,12 @@ struct ublksrv_ctrl_dev_info {
> > >   *
> > >   * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
> > >   * passed in.
> > >   */
> > >  #define              UBLK_IO_F_NEED_REG_BUF          (1U << 17)
> > > +/* Request has an integrity data buffer */
> > > +#define              UBLK_IO_F_INTEGRITY             (1U << 18)
> > >
> > >  /*
> > >   * io cmd is described by this structure, and stored in share memory, indexed
> > >   * by request tag.
> > >   *
> > > @@ -598,10 +604,20 @@ struct ublk_param_segment {
> > >       __u32   max_segment_size;
> > >       __u16   max_segments;
> > >       __u8    pad[2];
> > >  };
> > >
> > > +struct ublk_param_integrity {
> > > +     __u32   flags; /* LBMD_PI_CAP_* from linux/fs.h */
> > > +     __u8    interval_exp;
> > > +     __u8    metadata_size;
> > > +     __u8    pi_offset;
> > > +     __u8    csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
> > > +     __u8    tag_size;
> > > +     __u8    pad[7];
> > > +};
> > > +
> >
> > Just be curious, `pi_tuple_size` isn't defined, instead it is hard-coded in
> > ublk_integrity_pi_tuple_size().
> >
> > However, both scsi and nvme sets `pi_tuple_size`, so it means that ublk PI
> > supports one `subset` or scsi/nvme `pi_tuple_size` can be removed too?
> 
> blk_validate_integrity_limits() validates that pi_tuple_size matches
> the expected PI size for each csum_type value. So it looks like these
> fields are redundant. Yes, pi_tuple_size could probably be removed
> from the scsi/nvme block drivers too. But maybe there's value in
> having the drivers explicitly specify both values?

Ok, got it, then this interface looks fine.

For both scsi and nvme, `pi_tuple_size` is not read from hardware, and
actually calculated from guard type.


Thanks,
Ming


